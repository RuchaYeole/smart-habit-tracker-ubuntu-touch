cmake_minimum_required(VERSION 3.0.0)

project(smart-habit)

install(DIRECTORY qml DESTINATION .)
install(FILES manifest.json smart-habit.desktop smart-habit.apparmor DESTINATION .)
