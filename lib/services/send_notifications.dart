import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;


 class NotificationsServices{
  sendMessage(title,message)async{
    var headersList = {
 'Accept': '*/*',
 'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
 'Authorization': 'Bearer ya29.c.c0ASRK0GaRmvHL4zXpUxfJ_BZ4qVuQTow7dn6XVZZmz3BWeQPNeD9sEDEObIB0OVTusokUQJt0R47gqqyQ-oxxTs_ISFHUBGgbCGgWhkmQLl08kqdRxBEoPaHGkIWwHxo_aKFHcZYFwwNgVNmZBL0l10X01AxfsdOTj1IJgT4VSaGp5sZ6B0Ox8QFe6AxqAqYE84_he3YmIH2gt5HLHOk2Chij1Iu56M4alYHFbKP9CE4BiOzctydSdj_g9Su2gkmAID0-GQWh4citNSQiReMX85ozRXmtmVf0Xa5o0wPJbWR99gin3jCvGTqhc2kXYDSMAYZMT-GJL38TThnvQxcvh56jSrZLkXWPAmJtlgJJrtlHTa7ubewF_QfDYQE387KJUJFv2pMocflvSn3gnZjnmkIc571I6nX8m2VotgZ_rhiuwgztxjthjuzWXsOatruU-3waF0ce4l_U7092s8OZfmmU11z78xs5xO-nskgx6qai9vifqnYQY7410MRexQfgv0o5ejaRFrcpwbfQqcZUpl2h-vShtvxmc6obVF24jMxksYsXMb3woowI-5MYpUqa8oVMycepan4_6tBVSXw2Z-q2_OskhSVcIj-_R9q-WjxFm0V3qmXtX1nq0BYJe-QfMSM4ysogcfwofdMzY5tVrd18YWRI5c_y0ZlIXVklvuW1JRSl8230by_6loadVvhc-kh_xid7Mxb9m5k0xcwnX-o03ISYj1-ubRcwpsubQehq39sBocpgeQ_6hJQ1blqBYSFFI4dpjMaphntvR_xg_i0WO48XmhlvoOpR1Ih0mMU9JFFxizmi5ztY2iczZJRFfahzBB6ou6gqoZ3quY4sq4F_8vBRbQv272rzsr9UtolJ7Il30znIQX-Wsk643Mcr992gWhQZg_WcbOp8YXXJFz4z3X8JMtFsOUjoFMjtWazt8YlnMRBZuBj_1oX5jdYR0n_2m5XS9iYJR1-xst9r4Y3Mt0-087URrIhlSze8SSjOxnjrwBmpgIX',
 'Content-Type': 'application/json' 
};
var url = Uri.parse('https://fcm.googleapis.com/v1/projects/x-ray-2c7c1/messages:send');

var body = {
  "message": {
    "token": "fTuoDHe-TDiJ7JdPX_Iqdx:APA91bH2tUQbAUlE4tJa60Ht6r_fcqBeTXm0td_JGnf2z7U_sMBHLXqngXhqrhctIqtsj_ncJlrfhznduvkfqqg87iB5oQdnsdM8Nfib-Mq1z0EdIjTIEG0Ta8TrMOJ318gnyxjk_Gdg",
    "notification": {
      "title": title,
      "body": message
      
     
    },
    "data": {
      "story_id": "story_12345"
    }
  }
};

var req = http.Request('POST', url);
req.headers.addAll(headersList);
req.body = json.encode(body);


var res = await req.send();
final resBody = await res.stream.bytesToString();

if (res.statusCode >= 200 && res.statusCode < 300) {
  log(resBody);
}
else {
  log(res.reasonPhrase??'');
}
  }
}