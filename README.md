#  Pocket Tasks

Pocket Tasks is a simple and clean Flutter task manager app that helps users manage their daily tasks. You can add, edit, delete, and mark tasks as complete. Tasks are stored locally using Hive and managed with Riverpod.

---

##  Features

- Add new tasks with title, description, due date, and category
- Edit or delete existing tasks
- Mark tasks as completed or not completed
- View tasks filtered by:
  - To-do
  - In-Progress
  - Completed
- Sort tasks by due date
- Smooth animations and polished UI
- Task details screen
- Local data storage with Hive (offline support)
- State management using Riverpod
- 4 working tests included (unit and widget)

---

##  Tech Stack

- **Flutter** 3.22+ (null safety enabled)
- **Hive** (for offline local storage)
- **Riverpod** (for state management)
- **Material Design 3**
- **Flutter Test** (unit & widget testing)

---

##  Project Architecture

lib/
├── models/ # Task model (Hive)
├── providers/ # TaskListNotifier with Riverpod
├── services/ # HiveService for local box
├── screens/ # HomePage, TaskDetail, Add/Edit sheets
├── widgets/ # Reusable UI components (if needed)

yaml
Copy
Edit

---

##  State Management (Riverpod)

- `taskListProvider` is a `StateNotifierProvider` that holds the list of tasks.
- `TaskListNotifier` handles:
  - Loading tasks from Hive
  - Adding new tasks
  - Toggling task complete/incomplete
  - Deleting tasks
  - Updating tasks after edit

---

##  Testing

The app includes 4 tests:

1.  Unit test for Task model
2.  Widget test for adding a task
3.  Widget test for task filtering tabs

Run tests using:
```bash
flutter test
 How to Run the App
1. Clone the Project
bash
Copy
Edit
git clone https://github.com/your-username/pocket_task.git
cd pocket_task
2. Install Packages
bash
Copy
Edit
flutter pub get
3. (Optional) Generate Hive Type Adapter
bash
Copy
Edit
flutter packages pub run build_runner build
4. Run the App
bash
Copy
Edit
flutter run
 APK Build
A release APK is already included in the project inside the builds/ folder:

arduino
Copy
Edit
builds/
└── app-release.apk
You can also build a new APK with:

bash
Copy
Edit
flutter build apk --release
 Demo Walkthrough
You will find a short video walkthrough of the app inside the project folder:

Copy
Edit
demo.mp4
This demo is less than 2 minutes and shows the key features of the app.

 Project Summary
This project was built in response to a Flutter technical assessment for a junior to mid-level mobile developer role. The app meets all the listed requirements:

 Add/Edit/Delete tasks

 Completed/incomplete toggle

 Hive local storage

 Riverpod state management

 Filtering and sorting tasks

 Dark/light theme support

 4 working tests

 Clean code & folder structure

 README, APK, and Demo video

👨‍💻 Author
Victory Wagor
