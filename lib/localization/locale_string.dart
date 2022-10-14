import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'mobile_number': 'Mobile Number',
          'term_condition': 'Terms & Conditions',
          'i_accept': 'i accept',
          'request_otp': 'Request OTP',
          'empty_error_msg': 'Please enter a 10 digit mobile number',
          'checkbox_select_error' : 'Agree to our Terms & Conditions to proceed further',
          'sending_otp' : 'Sending OTP',
          'proceed_btn' : 'Proceed',
          'enter_otp': 'Enter OTP',
          'otp_message': 'We sent it to the number',
          'edit_number':'Edit Number',
          'resend_otp':'Resend OTP',
          'invalid_otp' : 'Invalid OTP entered. Please enter valid OTP',
          'select_prefer_lan' : 'Select prefer language'

        },
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
          'mobile_number': 'मोबाइल नंबर',
          'term_condition': 'नियम एवं शर्तें',
          'i_accept': 'मुझे स्वीकार है',
          'request_otp': 'अनुरोध ओटीपी',
          'empty_error_msg': 'कृपया मोबाइल नंबर दर्ज करें',
          'checkbox_select_error' : 'आगे बढ़ने के लिए हमारे नियम और शर्तों से सहमत हों',
          'sending_otp' : 'ओटीपी भेजना',
          'proceed_btn' : 'आगे बढ़ना',
          'enter_otp':'ओटीपी दर्ज करें',
          'otp_message': 'OTP इसे नंबर पर भेज दिया',
          'edit_number':'संख्या संपादित करें',
          'resend_otp':'ओटीपी पुनः भेजें',
          'invalid_otp' : 'कृपया मान्य ओटीपी दर्ज करें',
          'select_prefer_lan' : 'पसंदीदा भाषा चुनें'
        },
        'ka_IN': {
          'hello': 'ಹಲೋ ವರ್ಲ್ಡ್',
          'mobile_number': 'ಮೊಬೈಲ್ ನಂಬರ',
          'term_condition': 'ನಿಯಮ ಮತ್ತು ಶರತ್ತುಗಳು',
          'i_accept': 'ಒಪ್ಪುತ್ತೇನೆ',
          'request_otp': 'OTP ವಿನಂತಿಸಿ',
          'empty_error_msg': 'ದಯವಿಟ್ಟು ಮೊಬೈಲ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ',
          'checkbox_select_error' : 'ಮುಂದುವರೆಯಲು ನಮ್ಮ ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ',
          'sending_otp' : 'OTP ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ',
          'proceed_btn' : 'ಮುಂದುವರೆಯಲು',
          'enter_otp':'OTP ನಮೂದಿಸಿ',
          'otp_message': 'ನಾವು ಅದನ್ನು ನಂಬರ್‌ಗೆ ಕಳುಹಿಸಿದ್ದೇವೆ',
          'edit_number':'ಸಂಖ್ಯೆ ಸಂಪಾದಿಸಿ',
          'resend_otp':'OTP ಮರುಕಳುಹಿಸಿ',
          'invalid_otp' : 'ದಯವಿಟ್ಟು ಮಾನ್ಯ OTP ಅನ್ನು ನಮೂದಿಸಿ',
          'select_prefer_lan' : 'ಆದ್ಯತೆಯ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ'
        },
        'ma_IN': {
          'hello': 'हॅलो वर्ल्ड',
          'mobile_number': 'मोबाईल नंबर',
          'term_condition': 'अटी व शर्ती',
          'i_accept': 'हमला मान्य आहे',
          'request_otp': 'OTP ची विनंती करा',
          'empty_error_msg': 'कृपया मोबाईल नंबर टाका',
          'checkbox_select_error' : 'पुढे जाण्यासाठी आमच्या अटी आणि नियमांना सहमती द्या',
          'sending_otp' : 'OTP पाठवत आहे',
          'proceed_btn' : 'पुढे जा',
          'enter_otp':'OTP टाका',
          'otp_message': 'आम्ही ते नंबरवर पाठवले',
          'edit_number':'क्रमांक संपादित करा',
          'resend_otp':'OTP पुन्हा पाठवा',
          'invalid_otp' :  'कृपया वैध OTP प्रविष्ट करा',
          'select_prefer_lan' : 'प्राधान्य भाषा निवडा'

        },
        'te_IN': {
          'hello': 'హలో వరల్డ్',
          'mobile_number': 'మొబైల్ నంబర్',
          'term_condition': 'నిబంధనలు & షరతులు',
          'i_accept': 'నేను ఒప్పుకుంటున్నా',
          'request_otp': 'OTPని అభ్యర్థించండి',
          'empty_error_msg': 'దయచేసి మొబైల్ నంబర్‌ని నమోదు చేయండి',
          'checkbox_select_error' : 'కొనసాగడానికి మా నిబంధనలు & షరతులను అంగీకరించండి',
          'sending_otp' : 'OTPని పంపుతోంది',
          'proceed_btn' : 'కొనసాగండి',
          'enter_otp':'OTPని నమోదు చేయండి',
          'otp_message': 'నంబర్‌కి పంపించాం',
          'edit_number':'సంఖ్యను సవరించండి',
          'resend_otp':'OTP పంపు',
          'invalid_otp' : 'దయచేసి చెల్లుబాటు అయ్యే OTPని నమోదు చేయండి',
          'select_prefer_lan' : 'ప్రాధాన్య భాషని ఎంచుకోండి'
        },
        'ta_IN': {
          'hello': 'வணக்கம் உலகம்',
          'mobile_number': 'கைபேசி எண்',
          'term_condition': 'விதிமுறைகளும் நிபந்தனைகளும்',
          'i_accept': 'நான் ஏற்றுக்கொள்கிறேன்',
          'request_otp': 'OTP ஐக் கோரவும்',
          'empty_error_msg': 'மொபைல் எண்ணை உள்ளிடவும்',
          'checkbox_select_error' : 'தொடர எங்கள் விதிமுறைகள் மற்றும் நிபந்தனைகளை ஏற்கவும்',
          'sending_otp' : 'OTP அனுப்புகிறது',
          'proceed_btn' : 'தொடரவும்',
          'enter_otp':'OTP ஐ உள்ளிடவும்',
          'otp_message': 'எண்ணுக்கு அனுப்பினோம்',
          'edit_number':'எண்ணைத் திருத்து',
          'resend_otp':'OTP அனுப்பவும்',
          'invalid_otp' : 'சரியான OTP ஐ உள்ளிடவும்',
          'select_prefer_lan' : 'மொழியைத் தேர்ந்தெடுக்கவும்'


        },
        'mal_IN': {
          'hello': 'ഹലോ വേൾഡ്',
          'mobile_number': 'മൊബൈൽ നമ്പർ',
          'term_condition': 'നിബന്ധനകളും വ്യവസ്ഥകളും',
          'i_accept': 'ഞാൻ അംഗീകരിക്കുന്നു',
          'request_otp': 'OTP അഭ്യർത്ഥിക്കുക',
          'empty_error_msg': 'ദയവായി മൊബൈൽ നമ്പർ നൽകുക',
          'checkbox_select_error' : 'തുടരുന്നതിന് ഞങ്ങളുടെ നിബന്ധനകളും വ്യവസ്ഥകളും അംഗീകരിക്കുക',
          'sending_otp' : 'OTP അയയ്ക്കുന്നു',
          'proceed_btn' : 'തുടരുക',
          'enter_otp':'OTP നൽകുക',
          'otp_message': 'ഞങ്ങൾ അത് നമ്പറിലേക്ക് അയച്ചു',
          'edit_number':'നമ്പർ എഡിറ്റ് ചെയ്യുക',
          'resend_otp':'OTP അയയ്‌ക്കുക',
          'invalid_otp' : 'ദയവായി സാധുവായ OTP നൽകുക',
          'select_prefer_lan' : 'മുൻഗണന ഭാഷ തിരഞ്ഞെടുക്കുക'

        },
        'ban_IN': {
          'hello': 'হ্যালো',
          'mobile_number': 'মোবাইল নম্বর',
          'term_condition': 'শর্তাবলী',
          'i_accept': 'আমি স্বীকার করছি',
          'request_otp': 'অনুরোধ otp',
          'empty_error_msg': 'মোবাইল নম্বর লিখুন',
          'checkbox_select_error' : 'এগিয়ে যাওয়ার জন্য আমাদের শর্তাবলীতে সম্মত হন',
          'sending_otp' : 'OTP পাঠানো হচ্ছে',
          'proceed_btn' : 'এগিয়ে যান',
          'enter_otp':'OTP লিখুন',
          'otp_message': 'আমরা নাম্বারে পাঠিয়ে দিলাম',
          'edit_number':'নম্বর সম্পাদনা করুন',
          'resend_otp':'OTP আবার পাঠান',
          'invalid_otp' : 'অনুগ্রহ করে বৈধ ওটিপি লিখুন',
          'select_prefer_lan' : 'পছন্দের ভাষা নির্বাচন করুন'

        },


    'or_IN': {
      'hello': ' ନମ୍ବର',
      'mobile_number': 'ମୋବାଇଲ୍ ନମ୍ବର',
      'term_condition': 'ସର୍ତ୍ତାବଳୀ',
      'i_accept': 'ମୁଁ ସ୍ଵୀକାର କରୁଛି',
      'request_otp': 'OTP ଅନୁରୋଧ',
      'empty_error_msg': 'ଦୟାକରି ଏକ 10 ଅଙ୍କ ବିଶିଷ୍ଟ ମୋବାଇଲ୍ ନମ୍ବର ପ୍ରବେଶ କରନ୍ତୁ |',
      'checkbox_select_error' : 'ଆଗକୁ ବ to ିବା ପାଇଁ ଆମର ଚୁକ୍ତିନାମାକୁ ସହମତ |',
      'sending_otp' : 'OTP ପଠାଉଛି',
      'proceed_btn' : 'ଅଗ୍ରଗତି କର |',
      'enter_otp':'OTP ପ୍ରବେଶ କରନ୍ତୁ |',
      'otp_message': 'ଆମେ ଏହାକୁ ନମ୍ବରକୁ ପଠାଇଲୁ |',
      'edit_number':'ସଂଖ୍ୟା ସଂପାଦନ କରନ୍ତୁ |',
      'resend_otp':'OTP ପଠାନ୍ତୁ |',
      'invalid_otp' : 'ଦୟାକରି ବ valid ଧ OTP ପ୍ରବେଶ କରନ୍ତୁ |',
      'select_prefer_lan' : 'ପସନ୍ଦ ଭାଷା ଚୟନ କରନ୍ତୁ |'

    },












       };
}
