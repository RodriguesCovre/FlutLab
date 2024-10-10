import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedbacks'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, 
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Feedbacks').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple, 
                  ),
                  title: Text(snapshot.data.docs[index]['username']),
                  subtitle: Text(snapshot.data.docs[index]['message']),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Nenhum feedback disponível'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 30,
        color: Colors.deepPurple[50], 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, 
                  ),
                  onPressed: () async {
                    try {
                      await FirestoreService().postFeedback(messageController.text);
                      messageController.clear();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
