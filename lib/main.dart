import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'database_helper.dart';
import 'DeviceData.dart';
import 'package:collection/collection.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(), 
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<DeviceData> deviceDataList = [];

  void _uploadCSV() async {
    // Pilih file CSV
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path!;
      final input = File(path).readAsStringSync();
      final List<List<dynamic>> csvData = CsvToListConverter().convert(input);

      for (var row in csvData.skip(1)) {
        final deviceData = DeviceData(
          serial: row[0],
          name: row[1],
          dateTime: row[2],
          co: row[3],
          so: row[4],
          pm25: row[5],
        );
        await DatabaseHelper.instance.insertDeviceData(deviceData);
      }

      final data = await DatabaseHelper.instance.getDeviceData();
      setState(() {
        deviceDataList = data;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CSV Uploaded Successfully!')));
    }
  }

  void _resetData() async {
    await DatabaseHelper.instance.deleteAllDeviceData();
    setState(() {
      deviceDataList = [];
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Reset Successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    var groupedData = groupBy(deviceDataList, (DeviceData device) => device.name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload CSV Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _uploadCSV,
              icon: Icon(Icons.upload_file),
              label: Text('Upload CSV'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _resetData,
              icon: Icon(Icons.refresh),
              label: Text('Reset Data'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            Expanded(
              child: ListView(
                children: groupedData.keys.map((name) {
                  var devicesForName = groupedData[name]!;
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ExpansionTile(
                      title: Text(
                        name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Serial')),
                              DataColumn(label: Text('Device Name')),
                              DataColumn(label: Text('Date Time')),
                              DataColumn(label: Text('CO')),
                              DataColumn(label: Text('SO')),
                              DataColumn(label: Text('PM2.5')),
                            ],
                            rows: devicesForName.map((device) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(device.serial)),
                                  DataCell(Text(device.name)),
                                  DataCell(Text(device.dateTime)),
                                  DataCell(Text(device.co.toString())),
                                  DataCell(Text(device.so.toString())),
                                  DataCell(Text(device.pm25.toString())),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadCSV,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
