#!/usr/bin/env python3

from pywnp import WNPRedux
import signal
import json
import time
import sys
import socket

def clamp(x, minimum, maximum):
  return max(minimum, min(x, maximum))

def update_state_socket(conn):
  try:
    global state
    conn.sendall(state.encode())
  except: None

def handle_command(command):
  if command == "NOOP": return
  if command == "play_pause":
    WNPRedux.media_info.controls.try_toggle_play_pause()
  if command == "skip_previous":
    WNPRedux.media_info.controls.try_skip_previous()
  if command == "skip_next":
    WNPRedux.media_info.controls.try_skip_next()
  if command == "volume_up":
    WNPRedux.media_info.controls.try_set_volume(clamp(WNPRedux.media_info.volume + 2, 0, 100))
  if command == "volume_down":
    WNPRedux.media_info.controls.try_set_volume(clamp(WNPRedux.media_info.volume - 2, 0, 100))
  if command.startswith("setvolume"):
    WNPRedux.media_info.controls.try_set_volume(clamp(int(command.replace("setvolume", "")), 0, 100))

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind(("127.0.0.1", 5467))
server_socket.listen(1)

def logger(type, message):
  print(f"{type}: {message}")

WNPRedux.start(5468, '5.0.0', logger)

while True:
  conn, _ = server_socket.accept()
  global state
  state = json.dumps(WNPRedux.media_info, default=lambda x: x.__dict__).replace('_title', 'title').replace('_state', 'state').replace('_volume', 'volume')
  client_data = conn.recv(1024).decode().strip()
  if client_data:
    handle_command(client_data)
  update_state_socket(conn)
  conn.close()