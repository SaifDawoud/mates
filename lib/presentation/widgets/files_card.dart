import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mates/models/file_model.dart';
import 'package:mates/providers/files_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../widgets/sheet_item.dart';

class FilesCard extends StatefulWidget {
  final DeviceFile fileData;

  FilesCard({this.fileData});

  @override
  _FilesCardState createState() => _FilesCardState();
}

class _FilesCardState extends State<FilesCard> {
  double progress;
  bool isLoading = false;
  final dio = Dio();

  Future<void> downloadImage(String url) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName = basename(url);
    print(dir.path);
    print(fileName);
    final res = await dio.download(url, "${dir.path}/images/$fileName",
        onReceiveProgress: (rec, total) {
      if(total!=null){
        setState(() {
          progress = ((rec / total) );
        });
      }

    });
    print(res.statusCode);
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return BottomSheet(
            builder: (BuildContext context) {
              FilesProvider filesProvider = Provider.of(context);
              return Container(
                height: 230,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.fileData.fileName),
                      SheetItem(
                        icon: Icon(Icons.open_in_new),
                        label: Text('Open'),
                      ),
                      SheetItem(
                        icon: Icon(Icons.download_outlined),
                        label: Text('Download'),
                        onPressed: () {
                          /* filesProvider.downloadImage(fileData.url).then((value) => Navigator.of(context).pop());*/
                          Navigator.of(context).pop();
                          setState(() {
                            isLoading = !isLoading;
                          });
                          downloadImage(widget.fileData.url)
                              .then((value) => setState(() {
                                    isLoading = !isLoading;
                                  }));
                        },
                      ),
                      SheetItem(
                        icon: Icon(Icons.delete_outlined),
                        label: Text('Delete file'),
                      ),
                    ]),
              );
            },
            onClosing: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: isLoading
              ?CircularProgressIndicator(value:progress,backgroundColor:Colors.grey ,)
          /*CircularPercentIndicator(
                  radius: 40,
                  center: Text(
                    progress,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  lineWidth: 2,
                  animation: true,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                  percent: 1.0,
                )*/
              : Icon(Icons.file_present),
          title: Text(widget.fileData.fileName),
          subtitle: Row(
            children: [
              Text(
                "${widget.fileData.size} GB| Uploaded By ${widget.fileData.uploaderName}",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          trailing: IconButton(
            iconSize: 35,
            padding: EdgeInsets.all(2),
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showBottomSheet(context);
            },
          ),
        ),
      ],
    );
  }
}
