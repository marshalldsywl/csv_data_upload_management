A new and fresh basic Flutter project.

This project is a starting point for a basic Flutter prototype application.

CSV Data Upload and Management (Prototype)

Features

1. Upload CSV: Users can upload a CSV file, and the data will be parsed and stored in a local SQLite database.
2. Data Reset: Users can reset the stored data, clearing all records from the database.
3. Data Grouping: Data is grouped based on the device name and displayed in an organized and visually appealing manner.
4. Interactive Table: The data is presented in a scrollable table, with dynamic styling for better readability.

Technologies Used

1. Flutter: Framework for building the cross-platform mobile application.
2. SQLite: Database for storing and managing device data locally.
3. CSV: File format for importing data.
4. Flutter DataTable: For displaying device data in an organized, scrollable table format.
5. File Picker: For selecting and uploading CSV files from the user's device.

This is my first flutter project, this is what I have to install before starting the project 
1. Dart and Flutter Extensions Plugin for VS Code 
2. Change JDK version from 8 to 17 (My devices need a specifically jdk 17 to run it in my android devices) 
3. Change Gradle version from 7 to 8 (My Flutter version need Gradle version 8++ for debug) 
4. Everything in dependencies for import needs 
5. Android Driver to connect USB debugging 

Configuration 
1. Editing Environment Variables JAVA_HOME and Gradle Path to correct file location 
2. Activate USB Debugging in android devices by click build number in software information setting 7 times to open developer options 
3. Using Hot Reload feature to updating real time contents 
4. Config analysis_option.yaml file to ignore filename and use_key_in_widget_constructors warning 
5. Set up version control with basic git 

Build Instructions 
1. Clone the repository (git clone https://github.com/marshalldsywl/csv_data_upload_management.git) 
2. Open in VS Code (This prototype using VS Code) 
3. Preparing Flutter SDK and add to "PATH" 
4. Preparing Dependencies (flutter pub get) 
5. Preparing android adb usb driver 
6. Activate USB Debugging in android devices and connect with usb cable 7. Run (flutter run) 

NOTE: Tested using Samsung A528B Android 14 (Upside Down Cake), CSV File attached.