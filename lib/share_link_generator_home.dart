import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareLink extends StatefulWidget {
  @override
  _ShareLinkState createState() => _ShareLinkState();
}

class _ShareLinkState extends State<ShareLink> {

  final _formKey = GlobalKey<FormState>();

  String url, message;
  String generatedFacebookUrl, generatedTwitterUrl, generatedLinkedInUrl;
  bool fburlGenerated = false, twitterurlGenerated = false, linkedinurlGenerated = false, copiedfbLink = false, copiedtwitterLink = false, copiedLinkedinLink = false, validate = false;

  String _facebookLinkBuilder({url,message}){
    String link = "https://www.facebook.com/sharer/sharer.php?u=$url";
    print("facebook link :"+link);
    setState(() {
      generatedFacebookUrl = link;
      fburlGenerated = true;
    });
    return link;
  }

  String _twitterLinkBuilder({url,message}){
    String updatedMessage = message.toString().replaceAll(" ", "%20");
    String updatedUrl = url.toString().replaceAll(":", "%3A");
    updatedUrl = updatedUrl.toString().replaceAll("/", "%2F");
    updatedUrl = updatedUrl.toString().replaceAll("#", "%23");
    String link = "https://twitter.com/intent/tweet?url=$updatedUrl&text=$updatedMessage";
    print(link);
    setState(() {
      generatedTwitterUrl = link;
      twitterurlGenerated = true;
    });
    return link;
  }

  String _linkedinLinkBuilder({url,message}){
    String updatedMessage = message.toString().replaceAll(" ", "%20");
    String updatedUrl = url.toString().replaceAll(":", "%3A");
    updatedUrl = updatedUrl.toString().replaceAll("/", "%2F");
    updatedUrl = updatedUrl.toString().replaceAll("#", "%23");
    String link = "http://www.linkedin.com/shareArticle?mini=true&url=$updatedUrl&text=$updatedMessage";
    print(link);
    setState(() {
      generatedLinkedInUrl = link;
      linkedinurlGenerated = true;
    });
    return link;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Let's Generate"),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Text("Generate Link for Facebook, Twitter & LinkedIn",style: TextStyle(
                      color: Colors.blue[400],fontSize: 16
                  ),),
                  SizedBox(height: 20,),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[500]),
                              borderRadius:
                              BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.link,
                                  color: Colors.blue[500],
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                url = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Share Link',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle:
                              TextStyle(color: Colors.blue[500]),
                            ),
                            style: TextStyle(
                                fontSize: 15, color: Colors.blue[500]),
                          )),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("Must include https://...",
                      style: TextStyle(fontSize: 14,color: Colors.blue[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 16,),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[500]),
                              borderRadius:
                              BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.message,
                                  color: Colors.blue[500],
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                message = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Message',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle:
                              TextStyle(color: Colors.blue[500]),
                            ),
                            style: TextStyle(
                                fontSize: 15, color: Colors.blue[500]),
                          )),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("The message which will be shared",
                      style: TextStyle(fontSize: 14,color: Colors.blue[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 24,),
                  InkWell(
                    onTap: () {
                      _formKey.currentState.save();
                      if(url.isEmpty || message.isEmpty){
                        setState(() {
                          validate = true;
                        });
                      }else{
                        _facebookLinkBuilder(url: url,message: message);
                        _twitterLinkBuilder(url: url,message: message);
                        _linkedinLinkBuilder(url: url,message: message);

                      }
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            'Generate Link',
                            style: TextStyle(fontSize: 16, color: Colors.blue[400], fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(validate ? '''Make Sure both feilds are filled '''+
                        ''''then click "Generate Link"''':"",
                      style: TextStyle(fontSize: 14,color: Colors.red[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  Flexible(
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text(!twitterurlGenerated ? "": generatedTwitterUrl,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),),
                              onTap: ()  {
                              },),
                            SizedBox(height: 8,),
                            twitterurlGenerated ? GestureDetector(
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: generatedTwitterUrl));
                                  setState(() {
                                    copiedtwitterLink = true;
                                  });
                                },
                                child: Icon(Icons.content_copy,color: copiedtwitterLink ? Colors.blue:Colors.black26,)
                            ):Container(),
                            SizedBox(height: 20,),
                            InkWell(
                              child: Text(!fburlGenerated ? "": generatedFacebookUrl,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),),
                              onTap: ()  {
                              },),
                            SizedBox(height: 8,),
                            //FACEBOOK
                            fburlGenerated ? GestureDetector(
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: generatedFacebookUrl));
                                  setState(() {
                                    copiedfbLink = true;
                                  });
                                },
                                child: Icon(Icons.content_copy,color: copiedfbLink ? Colors.blue:Colors.black26,)
                            ):Container(),
                            //LinkedIn
                            SizedBox(height: 20,),
                            //FACEBOOK
                            InkWell(
                              child: Text(!linkedinurlGenerated ? "": generatedLinkedInUrl,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),),
                              onTap: ()  {
                              },),
                            SizedBox(height: 8,),
                            linkedinurlGenerated ? GestureDetector(
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: generatedLinkedInUrl));
                                  setState(() {
                                    copiedLinkedinLink = true;
                                  });
                                },
                                child: Icon(Icons.content_copy,color: copiedLinkedinLink ? Colors.blue:Colors.black26,)
                            ):Container(),

                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
