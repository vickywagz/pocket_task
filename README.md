# 📱 Pocket Task – Flutter To-Do App

A clean, offline-friendly Flutter task management app built for the junior-mid Flutter technical assessment.

## Features

- Add, edit, delete tasks
- Mark tasks as completed/incomplete
- Filter tasks by To-do, In-Progress, Completed
- Sort by due date
- Offline data via Hive
- Built with Flutter 3.22+, Riverpod

## State Management

Using **Riverpod (v2)** for clean state management via `StateNotifier`.

## Architecture

- `models/`: Hive data model
- `providers/`: Riverpod state logic
- `services/`: Hive storage
- `screens/`: UI views
- `widgets/`: Reusable UI components

## Getting Started

```bash
flutter pub get
flutter packages pub run build_runner build
flutter run
