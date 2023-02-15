import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Get_it_on_India1': 'Get it on India1',
          'When_with_India1': 'When with India1',
          'Now_with_India1': 'Now with India1',
          'loans_banner_text': 'No need to roam for loans anymore',
          'payment_banner_text': 'Earn with every transaction',

          'insurance_banner_text': 'Insure yourself & your loved ones',
          'saving_banner_text': 'The more you save, more you earn',
          //profile section
          'bank_accounts': 'Bank account(s)',
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',

          'earn_more_points': 'Earn More Points',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',
          'recharge': 'Recharge',
          'ways_to_reddem': 'Ways to redeem: ',
          'total_redeemed': 'Total redeemed: ',
          'hello': 'Hello World',
          'mobile_number': 'Mobile number',
          'term_condition': 'Terms and Conditions',
          'i_accept': 'I accept',
          'request_otp': 'Request OTP',
          'empty_error_msg': '*Please enter a valid 10 digit mobile number',
          'checkbox_select_error':
              'Agree to our Terms & Conditions to proceed further',
          'sending_otp': 'Sending OTP',
          'proceed_btn': 'Proceed',
          'enter_otp': 'Enter OTP',
          'otp_message': 'We have sent an OTP to',
          'edit_number': 'Edit number',
          'resend_otp': 'Resend OTP',
          'invalid_otp': 'Invalid OTP entered. Please enter valid OTP',
          'select_prefer_lan': 'Select preferred language',
          'loyalty_points': 'Loyalty points',
          'welcome': 'Welcome,',
          'cashback_india1_summary': 'Cashback by India1 summary',
          'cashback_summary': 'Cashback by India1 summary',

          'in': 'in',
          'redeem_points_now': 'Redeem Points Now',
          'home': 'Home',
          'payments': 'Payments',
          'loans': 'Loans',
          'insurance': 'Insurance',
          'savings': 'Savings',

          // home card

          'point': ' Points',
          'total_earned': 'Total earned: ',

          // loan section text

          'loan_categories': 'Loan categories',
          'payment_categories': 'Payment categories',
          'insurance_categories': 'Insurance categories',

          'personal': 'Personal',
          '2_wheeler': '2 Wheeler',
          'farm_eqp': 'Farm EQP',
          'track_based_loan': 'Track Based',
          'gold': 'Gold',
          'emi_card': 'Emi Card',
          'credit_card': 'Credit Card',
          'credit_score': 'Credit Score',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',

          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'Male': 'Male',
          'Female': 'Female',
          'Others': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',

          // drop down

          'my_profile': 'My Profile',
          'my_rewards': 'My Rewards',

          // insurance section text
          '4_wheeler': '4 Wheeler',
          'critical_illness': 'Personal Accident',

          //payments section

          'recharge': 'Recharge',
          'fast_teg': 'FASTag',
          'dth': 'DTH',

          // Saving section

          'fixed_deposit': 'Fixed Deposit',
          'digi_gold': 'Digi Gold',
          'digi_silver': 'Digi Silver',

          'current_balance': 'Current balance',

          'privacy_policy': 'Privacy policy'
        },
        'hi_IN': {
          'Get_it_on_India1': 'पाएं india1 में',
          'Now_with_India1': 'अब India1 के साथ',
          'When_with_India1': 'जब India1 के साथ',

          'loans_banner_text': 'क्या आपको लोन चाहिए?',
          'payment_banner_text': 'हर लेनदेन के साथ कमाएँ',

          'insurance_banner_text': 'अपना और अपने प्रियजनों का बीमा करें',
          'saving_banner_text':
              'जितना अधिक आप बचाते हैं, उतना अधिक आप कमाते हैं',

          'bank_accounts': 'बैंक खाते',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'एटीएम खोजें',
          'rewads_at_atm': 'एटीएम इनाम',
          'find_nearest_atm': 'निकटतम India1 एटीएम खोजें',
          'cashback': 'कैशबैक',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_redeemed': 'कुल भुनाया गया:',
          'point': 'अंक',
          'hello': 'नमस्ते दुनिया',
          'mobile_number': 'मोबाइल नंबर',
          'term_condition': 'नियम एवं शर्तें',
          'i_accept': 'मैं नियम और शर्तें स्वीकार करता हूं',
          'request_otp': 'ओटीपी का अनुरोध करें',
          'empty_error_msg': '*कृपया एक मान्य 10-अंकीय मोबाइल नंबर दर्ज करें',
          'checkbox_select_error':
              'आगे बढ़ने के लिए हमारे नियम और शर्तों से सहमत हों',
          'sending_otp': 'ओटीपी भेजना',
          'proceed_btn': 'आगे बढ़े',
          'enter_otp': 'ओटीपी दर्ज करें',
          'otp_message': 'OTP इसे नंबर पर भेज दिया',
          'edit_number': 'संख्या संपादित करें',
          'resend_otp': 'ओटीपी पुनः भेजें',
          'invalid_otp': 'कृपया मान्य ओटीपी दर्ज करें',
          'select_prefer_lan': 'पसंदीदा भाषा का चयन करें',
          'loyalty_points': 'Loyalty points',
          'welcome': 'स्वागत,',
          'cashback_india1_summary': 'India1 सारांश द्वारा कैशबैक',
          'cashback_summary': 'India1 सारांश द्वारा कैशबैक',
          'in': 'में',
          'redeem_points_now': 'पॉइंट्स अभी रिडीम करें',
          'home': 'घर',
          'payments': 'भुगतान',
          'loans': 'ऋण',
          'insurance': 'बीमा',
          'savings': 'जमा पूंजी',
          'total_earned': 'कुल अर्जित अंक:',

          //profile section
          'no_first_name': 'कोई पहला नाम नहीं',
          'no_last_name': 'कोई अंतिम नाम नहीं',
          'no_number': 'नंबर नहीं है',
          'no_email': 'कोई ईमेल आईडी नहीं',
          'no_dob': 'कोई जन्म तिथि नहीं',
          'not_entered': 'प्रवेश नहीं',
          'not_updated': 'अद्यतन नहीं हुआ',
          'add_persnl_details': 'व्यक्तिगत विवरण जोड़ें',
          'add_residntl_details': 'आवासीय विवरण जोड़ें',
          'no_residntl_data': 'कोई आवासीय डेटा नहीं मिला!',
          'add_occupation_details': 'व्यवसाय विवरण जोड़ें',
          'no_occupation_data': 'आपके किसी भी व्यवसाय का कोई विवरण नहीं मिला!',
          'bank_accounts': 'बैंक खाते',
          'no_bank_data': 'किसी भी सहेजे गए बैंक खाते का विवरण नहीं मिला!',
          'add_bank_acc': 'बैंक खाता जोड़ें',
          'upi_id': 'यूपीआई आईडी (एस) / वीपीए नंबर (एस)',
          'no_upi_data': 'कोई भी सहेजा गया यूपीआई / वीपीए विवरण नहीं मिला!',
          'add_upi_id': 'यूपीआई / वीपीए विवरण जोड़ें',

          // loan section

          'loan_categories': 'ऋण',
          'payment_categories': 'भुगतान categories',
          'insurance_categories': 'बीमा categories',
          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'अगला पृष्ठ',
          'personal_loan_header': 'व्यक्तिगत कर्ज़', // prsnl loan
          'gold_loan_header': 'स्वर्ण लोन', // gold loan
          'bike_loan_header': 'टू-व्हीलर लोन', // bike loan
          'farm_loan_header': 'कृषि लोन', //farm
          'trackBased_loan_header': 'ट्रैक आधारित लोन', // trackbased

          // loan details
          'loan_amount_desc':
              'स्लाइडर का उपयोग करके आवश्यक लोन राशि दर्ज करें या टेक्स्ट फ़ील्ड में टाइप करें',
          'track_based_loan_details_desc':
              'उप-उत्पाद चुनें जिसके लिए आप लोन चाहते हैं',
          'farm_loan_details_desc':
              'वह उत्पाद चुनें जिसके बदले आप लोन चाहते हैं',

          // loans => steppers headers
          'loan_amount_header': 'उधार की राशि',
          'personal_header_stpr': 'पर्सनल/निजी',
          'residential_header_stpr': 'आवासीय',
          'occupational_header_stpr': 'व्यवसाय',
          'additional_header_stpr': 'अतिरिक्त',
          'loan_details_header_stpr': 'लोन विवरण',
          'personal_details': 'व्यक्तिगत विवरण',
          'residential_details': 'आवासीय विवरण',
          'occupation_details': 'व्यवसाय विवरण',
          'additional_information': 'अतिरिक्त जानकारी',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*यह क्षेत्र अनिवार्य है',
          'first_name_e': '*पहला नाम अनिवार्य है',
          'last_name_e': '*अंतिम नाम अनिवार्य है',
          'mobile_num_e': '*मोबाइल नंबर 10 अंक होना चाहिए',
          'email_id_e': '*ईमेल आईडी अनिवार्य है',
          'date_of_birth_e': "*जन्म तिथि अनिवार्य है",
          'maritial_status_e': 'वैवाहिक स्थिति अनिवार्य है',
          'pan_num_e': '*पैन नंबर अनिवार्य है',
          'ad_e': '*पता अनिवार्य है',
          'pincode_e': '*पिनकोड को भरने की जरूरत है',

          // bottom sheet
          'want_to_proceed_quest': 'क्या आपकी आगे बढ़ने की इच्छा है?',
          'proceed_description':
              'कृपया प्रदान किए गए सभी विवरणों को सत्यापित करें। एक बार सबमिट करने के बाद, आपको विवरण बदलने की अनुमति नहीं दी जाएगी।',
          'apply_loan': 'लोन के लिए आवेदन करें',

          //applied success
          'loan_application_submitted': 'लोन आवेदन प्रस्तुत!',
          'team_will_get_back': 'टीम आपसे संपर्क करेगी।',

          //ask
          //denied success

          //select lender
          'select_lender': 'आगे बढ़ने के लिए लोनदाता का चयन करें',
          'loan_provider': 'व्यक्तिगत लोन प्रदाता',
          'explore': 'खोजना',

          //choose lender
          'one_lender_select': 'सूची में से एक लोनदाता चुनें',
          //ask
          //type of loan
          'min_doc': 'न्यूनतम प्रलेखन',
          'paperless': 'पेपरलेस प्रक्रिया',
          'max_amount': 'अधिकतम राशि',
          'tenure': 'कार्यकाल',
          'interest': 'ब्याज/एम',
          'view_details': 'विवरण देखें',
          'apply': 'आवेदन करना',

          //provider details
          'top_features': 'शीर्ष सुविधाएँ',
          'other_details': 'अन्य जानकारी',
          'interest_rate': 'ब्याज दर',
          'max_age': 'अधिकतम आयु',
          'min_age': 'न्यूनतम आयु',
          'loan_tenure': 'लोन -कार्यकाल',
          'apply_now': 'अभी अप्लाई करें',
          // unique=> gold loan
          'gold_loan_process': 'स्वर्ण लोन प्रक्रिया',
          // unique => bike loan

          'vehicle_loan_process': '  वाहन लोन प्रक्रिया',

          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'पहला नाम',
          'enter_first_name': 'अपना पहला नाम दर्ज करें',
          'last_name': 'उपनाम',
          'enter_last_name': 'अपना अंतिम नाम दर्ज करें',
          'mobile_num': 'मोबाइल नंबर',
          'enter_mobile_num': 'मोबाइल नंबर दर्ज करें',
          'alt_num': 'वैकल्पिक नंबर',
          'enter_alt_num': 'वैकल्पिक संख्या दर्ज करें',
          'email_id': 'ईमेल आईडी',
          'enter_email_id': 'यहाँ ईमेल आईडी दर्ज करें',
          //ask
          'date_of_birth': "जन्म की तिथि (दिनांक / महीना / बर्ष)",
          'gender': 'लिंग',
          'Male': 'पुरुष',
          'Female': 'महिला',
          'Others': 'अन्य',
          'maritial_status': 'वैवाहिक स्थिति',
          'select_maritial_status': 'अपनी वैवाहिक स्थिति का चयन करें',
          'select_option': 'एक विकल्प चुनें',
          'married': 'विवाहित',
          'unmarried': 'अविवाहित',
          'widowed': 'विधवा',

          //Residential Form
          'ad_line1': 'पता पंक्ति 1',
          'ad_line1_h': 'डोर नंबर, क्रॉस आदि दर्ज करें',
          'ad_line2': 'पता पंक्ति नं। 2',
          'ad_line2_h': 'क्षेत्र, सड़क, लैंडमार्क, आदि में प्रवेश करें',
          'pincode': 'पिन कोड',
          'enter_pincode': 'यहाँ पिन कोड दर्ज करें',
          'city': 'शहर : शहर देखने के लिए पिनकोड दर्ज करें',
          'state': 'राज्य: राज्य देखने के लिए पिनकोड दर्ज करें',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'रोजगार के प्रकार',
          'employment_type_h': 'अपना रोजगार प्रकार चुनें',
          'monthly_income': 'मासिक आय',
          'salary_mode': 'वेतन मोड',
          'salary_mode_h': 'चुनें कि आप कैसे वेतन प्राप्त करते हैं',
          'pan_num': 'पैन नंबर',
          'pan_num_h': 'अपना पैन नंबर दर्ज करें',

          //additional_info

          'months_residing_at': 'रहने वाले महीनों की संख्या',
          'highest_qualification': 'उच्चतम योग्यता',
          'comapany_name': 'कंपनी का नाम',
          'designation': 'पद',
          'work_exp': 'कार्य अनुभव',
          'office_add1': 'र्यालय का पता लाइन 1',
          'office_add2': 'र्यालय का पता लाइन 2',
          'office_add_h': 'पता',
          'netbanking_quest': 'क्या आप नेटबैंकिंग का उपयोग करते हैं?',
          'yes': 'हाँ',
          'no': 'नहीं',
          'existing_loans_quest': 'क्या आपके पास कोई मौजूदा लोन है?',
          'active_existng_loans_num': 'सक्रिय / मौजूदा लोनों की संख्या',

          //-----------------

          //bike loan unique
          'product': 'उत्पाद',
          'product_h': 'एक उत्पाद चुनो',
          'model': 'आदर्श',
          'model_h': 'एक मॉडल का चयन करें',

          //track_based_unique
          'sub_product': 'उप -उत्पाद',
          'sub_product_h': 'उप उत्पाद का चयन करें',

          //farm loan unique
          'loan_requirement': 'लोन की आवश्यकता',
          'loan_requirement_h': 'लोन के लिए विकल्प चुनें',
          'loan_requirement_e': '*आगे बढ़े अनिवार्य है',
          // drop down

          'my_profile': 'प्रोफाइल',
          'my_rewards': 'पुरस्कार',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'रिडीम',
          'fast_teg': 'फास्टैग',
          'dth': 'डीटीएच',

          // Saving section

          'fixed_deposit': 'एफडी',
          'digi_gold': 'डिजी गोल्ड',
          'digi_silver': 'डिजी सिल्वर',

          'current_balance': 'वर्तमान शेष',

          'privacy_policy': 'गोपनीयता नीति'
        },
        'ka_IN': {
          'Get_it_on_India1': 'ಇಂಡಿಯಾ 1 ನಲ್ಲಿ ಪಡೆಯಿರಿ',
          'Now_with_India1': 'ಈಗ ಇಂಡಿಯಾ 1 ನೊಂದಿಗೆ',
          'When_with_India1': 'ಇಂಡಿಯಾ 1 ನೊಂದಿಗೆ ಬಂದಾಗ',

          //profile section
          'loans_banner_text': 'ಇನ್ನು ಮುಂದೆ ಸಾಲಕ್ಕಾಗಿ ಸಂಚರಿಸುವ ಅಗತ್ಯವಿಲ್ಲ',
          'payment_banner_text': 'ಪ್ರತಿ ವಹಿವಾಟಿನೊಂದಿಗೆ ಸಂಪಾದಿಸಿ',

          'insurance_banner_text':
              'ನಿಮ್ಮನ್ನು ಮತ್ತು ನಿಮ್ಮ ಪ್ರೀತಿಪಾತ್ರರನ್ನು ವಿಮೆ ಮಾಡಿ',
          'saving_banner_text':
              'ನೀವು ಹೆಚ್ಚು ಉಳಿಸುತ್ತೀರಿ, ಹೆಚ್ಚು ನೀವು ಗಳಿಸುತ್ತೀರಿ',

          'point': ' ಅಂಕಗಳು',
          'bank_accounts': 'ಬ್ಯಾಂಕ್ ಖಾತೆಗಳು)',
          'no_first_name': 'ಮೊದಲ ಹೆಸರು ಇಲ್ಲ',
          'no_last_name': 'ಕೊನೆಯ ಹೆಸರು ಇಲ್ಲ',
          'no_number': 'ಸಂಖ್ಯೆ ಇಲ್ಲ',
          'no_email': 'ಇಮೇಲ್ ID ಇಲ್ಲ',
          'no_dob': 'ಡಾಬ್ ಇಲ್ಲ',
          'not_entered': 'ನಮೂದಿಸಲಾಗಿಲ್ಲ',
          'not_updated': 'ನವೀಕರಿಸಲಾಗಿಲ್ಲ',
          'add_persnl_details': 'ವೈಯಕ್ತಿಕ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',
          'add_residntl_details': 'ವಸತಿ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',
          'no_residntl_data': 'ಯಾವುದೇ ವಸತಿ ಡೇಟಾವನ್ನು ಕಂಡುಹಿಡಿಯಲಾಗಲಿಲ್ಲ!',
          'add_occupation_details': 'ಉದ್ಯೋಗ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',
          'no_occupation_data':
              'ನಿಮ್ಮ ಯಾವುದೇ ಉದ್ಯೋಗ ವಿವರಗಳನ್ನು ಕಂಡುಹಿಡಿಯಲಾಗಲಿಲ್ಲ!',
          'bank_accounts': 'ಬ್ಯಾಂಕ್ ಖಾತೆಗಳು)',
          'no_bank_data':
              'ಯಾವುದೇ ಉಳಿಸಿದ ಬ್ಯಾಂಕ್ ಖಾತೆ ವಿವರಗಳನ್ನು ಕಂಡುಹಿಡಿಯಲಾಗಲಿಲ್ಲ!',
          'add_bank_acc': 'ಬ್ಯಾಂಕ್ ಖಾತೆ ಸೇರಿಸಿ',
          'upi_id': 'ಯುಪಿಐ  (ಎಸ್) / ವಿಪಿಎ  (ಗಳು)',
          'no_upi_data':
              'ಯಾವುದೇ ಉಳಿಸಿದ ಯುಪಿಐ / ವಿಪಿಎ ವಿವರಗಳನ್ನು ಕಂಡುಹಿಡಿಯಲಾಗಲಿಲ್ಲ!',
          'add_upi_id': 'ಯುಪಿಐ / ವಿಪಿಎ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',
          'earn_more_points': 'ಹೆಚ್ಚಿನ ಅಂಕಗಳನ್ನು ಗಳಿಸಿ',
          'locate_atm': 'ಅನ್ನು ಪತ್ತೆ ಮಾಡಿ',
          'rewads_at_atm': 'ಹೆಚ್ಚಿನ ಅಂಕಗಳನ್ನು ಗಳಿಸಿ',
          'find_nearest_atm': 'ಹತ್ತಿರದ ಭಾರತ 1 ಎಟಿಎಂ ಅನ್ನು ಹುಡುಕಿ',
          'cashback': 'ನಗದುಬರೆ',

          'recharge': 'ಪುನರ್ಭರ್ತಿ',
          'ways_to_reddem': 'ಪುನಃ  ಮಾರ್ಗಗಳು:',
          'total_redeemed': 'ಒಟ್ಟು ವಿಮೋಚನೆ:',
          'total_earned': 'ಗಳಿಸಿದ ಒಟ್ಟು:',
          'current_balance': 'ಪ್ರಸ್ತುತ ಸಮತೋಲನ',
          'hello': 'ಹಲೋ ವರ್ಲ್ಡ್',
          'mobile_number': 'ಮೊಬೈಲ್ ನಂಬರ',
          'term_condition': 'ನಿಯಮ ಮತ್ತು ಶರತ್ತುಗಳು',
          'i_accept': 'ಒಪ್ಪುತ್ತೇನೆ',
          'request_otp': 'OTP ವಿನಂತಿಸಿ',
          'empty_error_msg': '*Please enter a valid 10 digit mobile number',
          'checkbox_select_error':
              'ಮುಂದುವರೆಯಲು ನಮ್ಮ ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ',
          'sending_otp': 'OTP ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ',
          'proceed_btn': 'ಮುಂದುವರೆಯಲು',
          'enter_otp': 'ಒಟಿಪಿ ನಮೂದಿಸಿ',
          'otp_message': 'ನಾವು ಅದನ್ನು ನಂಬರ್‌ಗೆ ಕಳುಹಿಸಿದ್ದೇವೆ',
          'edit_number': 'ಸಂಖ್ಯೆ ಸಂಪಾದಿಸಿ',
          'resend_otp': 'OTP ಮರುಕಳುಹಿಸಿ',
          'invalid_otp': 'ದಯವಿಟ್ಟು ಮಾನ್ಯ OTP ಅನ್ನು ನಮೂದಿಸಿ',
          'select_prefer_lan': 'ಆದ್ಯತೆಯ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',
          'loyalty_points': 'ಬಿಂಬಗಳು',
          'welcome': 'ಸ್ವಾಗತ,',
          'cashback_india1_summary': 'ಭಾರತದಿಂದ ಕ್ಯಾಶ್‌ಬ್ಯಾಕ್ 1 ಸಾರಾಂಶ',
          'cashback_summary': 'ಭಾರತ 1 ಸಾರಾಂಶದಿಂದ ಕ್ಯಾಶ್‌ಬ್ಯಾಕ್',
          'in': 'ಒಗೆ',
          'redeem_points_now': 'ಈಗ ಅಂಕಗಳನ್ನು ಪಡೆದುಕೊಳ್ಳಿ',
          'home': 'ಮನೆ',
          'payments': 'ಪಾವತಿಗಳು',
          'loans': 'ದಾನ',
          'insurance': 'ವಿಮೆ',
          'savings': 'ಉಳಿತಾಯ',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'ವೈಯಕ್ತಿಕ ಸಾಲ', // prsnl loan
          'gold_loan_header': 'ಚಿನ್ನದ ಸಾಲ', // gold loan
          'bike_loan_header': 'ಬೈಕು', // bike loan
          'farm_loan_header': 'ಕೃಷಿ ಸಾಲ', //farm
          'trackBased_loan_header': 'ಟ್ರ್ಯಾಕ್ ಆಧಾರಿತ ಸಾಲ', // trackbased

          // loan details
          'loan_amount_desc':
              'ಪಠ್ಯ ಕ್ಷೇತ್ರದಲ್ಲಿ ಸ್ಲೈಡರ್ ಅಥವಾ ಟೈಪ್ ಬಳಸಿ ಅಗತ್ಯವಿರುವ ಸಾಲದ ಮೊತ್ತವನ್ನು ನಮೂದಿಸಿ', //done
          'track_based_loan_details_desc':
              'ನೀವು ಸಾಲವನ್ನು ಬಯಸುವ ಉಪ-ಉತ್ಪನ್ನವನ್ನು ಆರಿಸಿ',
          'farm_loan_details_desc': 'ನೀವು ಸಾಲವನ್ನು ಬಯಸುವ ಉತ್ಪನ್ನವನ್ನು ಆರಿಸಿ',

          // loans => steppers headers
          'loan_amount_header': 'ಸಾಲದ ಪ್ರಮಾಣ',
          'personal_header_stpr': 'ವೈಯಕ್ತಿಕ',
          'residential_header_stpr': 'ವಸತಿ',
          'occupational_header_stpr': 'ಉದ್ಯೋಗ',
          'additional_header_stpr': 'ಹೆಚ್ಚುವರಿ',
          'loan_details_header_stpr': 'ಸಾಲದ ವಿವರಗಳು',
          'personal_details': 'ವೈಯಕ್ತಿಕ ವಿವರಗಳು',
          'residential_details': 'ವಸತಿ ವಿವರಗಳು',
          'occupation_details': 'ಉದ್ಯೋಗ ವಿವರಗಳು',
          'additional_information': 'ಹೆಚ್ಚುವರಿ ಮಾಹಿತಿ',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*ಈ ಕ್ಷೇತ್ರವು ಕಡ್ಡಾಯವಾಗಿದೆ',
          'first_name_e': '*ಮೊದಲ ಹೆಸರು ಇಲ್ಲಿ ಕಡ್ಡಾಯವಾಗಿದೆ',
          'last_name_e': '*ಕೊನೆಯ ಹೆಸರು ಕಡ್ಡಾಯವಾಗಿದೆ',
          'mobile_num_e': '*ಮೊಬೈಲ್ ಸಂಖ್ಯೆ 10 ಅಂಕೆಗಳಾಗಿರಬೇಕು',
          'email_id_e': '*ಇಮೇಲ್ ಐಡಿ ಇಲ್ಲಿ ಕಡ್ಡಾಯವಾಗಿದೆ',
          'date_of_birth_e': "*ಹುಟ್ಟಿದ ದಿನಾಂಕ ಕಡ್ಡಾಯ",
          'maritial_status_e': 'ವೈವಾಹಿಕ ಸ್ಥಿತಿ ಕಡ್ಡಾಯವಾಗಿದೆ',
          'pan_num_e': '*ಪ್ಯಾನ್ ಸಂಖ್ಯೆ ಕಡ್ಡಾಯವಾಗಿದೆ',
          'ad_e': '*ವಿಳಾಸ ಕಡ್ಡಾಯವಾಗಿದೆ',
          'pincode_e': '*ಪಿಂಕೋಡ್ ತುಂಬಬೇಕಾಗಿದೆ',

          // bottom sheet
          'want_to_proceed_quest': 'ನೀವು ಮುಂದುವರಿಯಲು ಬಯಸುವಿರಾ?',
          'proceed_description':
              'ದಯವಿಟ್ಟು ಒದಗಿಸಿದ ಎಲ್ಲಾ ವಿವರಗಳನ್ನು ಪರಿಶೀಲಿಸಿ. ಒಮ್ಮೆ ಅದನ್ನು ಸಲ್ಲಿಸಿದ ನಂತರ, ವಿವರಗಳನ್ನು ಬದಲಾಯಿಸಲು ನಿಮಗೆ ಅನುಮತಿಸಲಾಗುವುದಿಲ್ಲ.',
          'apply_loan': 'ಸಾಲಕ್ಕೆ ಅರ್ಜಿ ಸಲ್ಲಿಸಿ',

          //applied success
          'loan_application_submitted': 'ಸಾಲ ಅರ್ಜಿ ಸಲ್ಲಿಸಲಾಗಿದೆ!',
          'team_will_get_back': 'ತಂಡವು ನಿಮ್ಮನ್ನು ಮರಳಿ ಪಡೆಯುತ್ತದೆ.',

          //ask
          //denied success

          //select lender
          'select_lender': 'ಮುಂದುವರಿಯಲು ಸಾಲಗಾರನನ್ನು ಆಯ್ಕೆಮಾಡಿ',
          'loan_provider': 'ವೈಯಕ್ತಿಕ ಸಾಲ ಒದಗಿಸುವವರು',
          'explore': 'ಅನ್ವೇಷಿಸು',

          //choose lender
          'one_lender_select': 'ಪಟ್ಟಿಯಿಂದ ಒಂದು ಸಾಲಗಾರನನ್ನು ಆರಿಸಿ',
          'min_doc': 'ಕನಿಷ್ಠ ದಸ್ತಾವೇಜನ್ನು',
          'paperless': 'ಕಾಗದರಹಿತ ಪ್ರಕ್ರಿಯೆ',
          'max_amount': 'ಗರಿಷ್ಠ ಪ್ರಮಾಣ',
          'tenure': 'ಅಧಿಕಾರ:',
          'interest': 'ಬಡ್ಡಿ/ಮೀ',
          'view_details': 'ವಿವರಗಳನ್ನು ವೀಕ್ಷಿಸಿ',
          'apply': 'ಅನ್ವಯಿಸು',

          //provider details
          'top_features': 'ಉನ್ನತ ವೈಶಿಷ್ಟ್ಯಗಳು',
          'other_details': 'ಇತರ ವಿವರಗಳು',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'ಚಿನ್ನದ ಸಾಲ ಪ್ರಕ್ರಿಯೆ',
          // unique => bike loan
          'vehicle_loan_process': 'ವಾಹನ ಸಾಲ ಪ್ರಕ್ರಿಯೆ',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'ಮೊದಲ ಹೆಸರು',
          'enter_first_name': 'ನಿಮ್ಮ ಮೊದಲ ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
          'last_name': 'ನಿಮ್ಮ ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
          'enter_last_name': 'ನಿಮ್ಮ ಕೊನೆಯ ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
          'mobile_num': 'ಮೊಬೈಲ್ ನಂಬರ',
          'enter_mobile_num': 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ',
          'alt_num': 'ಪರ್ಯಾಯ ಸಂಖ್ಯೆ',
          'enter_alt_num': 'ಪರ್ಯಾಯ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ',
          'email_id': 'ಇಮೇಲ್ ಐಡಿ',
          'enter_email_id': 'ಇಲ್ಲಿ ಇಮೇಲ್ ಐಡಿ ನಮೂದಿಸಿ',
          //ask
          'date_of_birth': "ಹುಟ್ಟಿದ ದಿನಾಂಕ (Dd-Mm-Yyyy)",
          'gender': 'ಲಿಂಗ',
          'male': 'ಪುರುಷ',
          'female': 'ಹೆಣ್ಣು',
          'other': 'ಬೇರೆ',
          'maritial_status': 'ವೈವಾಹಿಕ ಸ್ಥಿತಿ',
          'select_maritial_status': 'ನಿಮ್ಮ ವೈವಾಹಿಕ ಸ್ಥಿತಿಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',
          'select_option': 'ಆಯ್ಕೆಯನ್ನು ಆರಿಸಿ',
          'married': 'ವಿವಾಹಿತ',
          'unmarried': 'ಅವಿವಾಹಿತ',
          'widowed': 'ವಿಧವೆಯ',

          //Residential Form
          'ad_line1': 'ವಿಳಾಸ ಸಾಲು 1',
          'ad_line1_h': 'ಬಾಗಿಲು ಇಲ್ಲ, ಅಡ್ಡ, ಇತ್ಯಾದಿ',
          'ad_line2': 'ವಿಳಾಸ ಸಾಲು 2',
          'ad_line2_h': 'ಪ್ರದೇಶ, ರಸ್ತೆ, ಹೆಗ್ಗುರುತು ಇತ್ಯಾದಿಗಳನ್ನು ನಮೂದಿಸಿ',
          'pincode': 'ಒಂದು ತರುಣ',
          'enter_pincode': 'ಪಿನ್ಕೋಡ್ ಅನ್ನು ಇಲ್ಲಿ ನಮೂದಿಸಿ',
          'city': 'ನಗರ: ನಗರವನ್ನು ವೀಕ್ಷಿಸಲು ಪಿಂಕೋಡ್ ಅನ್ನು ನಮೂದಿಸಿ',
          'state': 'ರಾಜ್ಯ: ರಾಜ್ಯವನ್ನು ವೀಕ್ಷಿಸಲು ಪಿಂಕೋಡ್ ಅನ್ನು ನಮೂದಿಸಿ',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'ಉದ್ಯೋಗದ ರೀತಿ',
          'employment_type_h': 'ನಿಮ್ಮ ಉದ್ಯೋಗ ಪ್ರಕಾರವನ್ನು ಆರಿಸಿ',
          'monthly_income': 'ಮಾಸಿಕ ಆದಾಯ',
          'salary_mode': 'ಸಂಬಳ ಪಡೆಯುವ ಕ್ರಮ',
          'salary_mode_h': 'ನೀವು ವೇತನವನ್ನು ಹೇಗೆ ಸ್ವೀಕರಿಸುತ್ತೀರಿ ಎಂಬುದನ್ನು',
          'pan_num': 'ಅಬ್ಬರ',
          'pan_num_h': 'ನಿಮ್ಮ ಪ್ಯಾನ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ',

          //additional_info

          'months_residing_at': 'ನಲ್ಲಿ ವಾಸಿಸುವ ತಿಂಗಳುಗಳ ಸಂಖ್ಯೆ',
          'highest_qualification': 'ಅತ್ಯುನ್ನತ ಅರ್ಹತೆ',
          'comapany_name': 'ಸಂಸ್ಥೆಯ ಹೆಸರು',
          'designation': 'ಹುದ್ದೆ',
          'work_exp': 'ಕೆಲಸದ ಅನುಭವ',
          'office_add1': 'ಕಚೇರಿ ವಿಳಾಸ ಸಾಲು 1',
          'office_add2': 'ಕಚೇರಿ ವಿಳಾಸ ಸಾಲು 2',
          'office_add_h': 'ಭಾಷಣ',
          'netbanking_quest': 'ನೀವು ನೆಟ್‌ಬ್ಯಾಂಕಿಂಗ್ ಬಳಸುತ್ತೀರಾ?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'ನೀವು ಸಾಲವನ್ನು ಹೊಂದಿದ್ದೀರಾ?',
          'active_existng_loans_num': 'ಸಕ್ರಿಯ / ಅಸ್ತಿತ್ವದಲ್ಲಿರುವ ಸಾಲಗಳ ಸಂಖ್ಯೆ',

          //-----------------

          //bike loan unique
          'product': 'ಉತ್ಪನ್ನ',
          'product_h': 'ಉತ್ಪನ್ನವನ್ನು ಆಯ್ಕೆಮಾಡಿ',
          'model': 'ಮಾದರಿ',
          'model_h': 'ಮಾದರಿಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',

          //track_based_unique
          'sub_product': 'ಉಪ ಉತ್ಪನ್ನ',
          'sub_product_h': 'ಉಪ ಉತ್ಪನ್ನವನ್ನು ಆಯ್ಕೆಮಾಡಿ',

          //farm loan unique
          'loan_requirement': 'ಸಾಲದ ಅವಶ್ಯಕತೆ',
          'loan_requirement_h': 'ಸಾಲಕ್ಕಾಗಿ ಆಯ್ಕೆಯನ್ನು ಆರಿಸಿ',
          'loan_requirement_e': '*ಮುಂದುವರಿಯಲು ಇದು ಕಡ್ಡಾಯವಾಗಿದೆ',

          // drop down

          'my_profile': 'ಪ್ರಚಾರ',
          'my_rewards': 'ಪ್ರತಿಫಲಗಳು',

          // loan section
          'loan_categories': 'ಮಾನ್ಯ',
          'payment_categories': 'ಸಾಲಗಳು',
          'insurance_categories': 'ಸಾಲಗಳು ',

          'personal': 'ವೈಯಕ್ತಿಕ',
          '2_wheeler': '2 ವೀಲರ್',
          'farm_eqp': 'ಫಾರ್ಮ್ ಇಕ್ಯೂಪಿ',
          'track_based_loan': 'टರ್ಯಾಕ್',
          'gold': 'ಚಿನ್ನ',
          'emi_card': 'emi ಕಾರ್ಡ್',
          'credit_card': 'ಕ್ರೆಡಿಟ್ ಕಾರ್ಡ್',
          'credit_score': 'ಕ್ರೆಡಿಟ್ ಸ್ಕೋರ್',

          // insurance section text
          '4_wheeler': '4 ಚಕ್ರದ ವಾಹನ',
          'critical_illness': 'ಗಂಭೀರ ಅನಾರೋಗ್ಯ',

          //payments section

          'recharge': 'ಪುನರ್ಭರ್ತಿ',
          'fast_teg': 'ದಳ',
          'dth': 'ಡಿತ್',

          // Saving section

          'fixed_deposit': 'ಸ್ಥಿರ ಠೇವಣಿ',
          'digi_gold': 'ಎಫ್‌ಡಿ (ಸ್ಥಿರ ಠೇವಣಿ)',
          'digi_silver': 'ರಾಶಿ ಚಿನ್ನ',

          'privacy_policy': 'ಗೌಪ್ಯತಾ ನೀತಿ'
        },
        'ma_IN': {
          'bank_accounts': 'बैंक खाते',

          //profile section
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_redeemed': 'Total redeemed:',
          'total_earned': 'कुल अर्जित अंक:',
          'cashback_summary': 'Cashback by India1 summary',
          'current_balance': 'चालू शिल्लक',
          'hello': 'हॅलो वर्ल्ड',
          'mobile_number': 'मोबाईल नंबर',
          'term_condition': 'अटी व शर्ती',
          'i_accept': 'मी नियम आणि अटी स्वीकारतो',
          'request_otp': 'OTP ची विनंती करा',
          'empty_error_msg': '*कृपया वैध 10-अंकी मोबाईल नंबर प्रविष्ट करा',
          'checkbox_select_error':
              'पुढे जाण्यासाठी आमच्या अटी आणि नियमांना सहमती द्या',
          'sending_otp': 'OTP पाठवत आहे',
          'proceed_btn': 'पुढे जा',
          'enter_otp': 'OTP एंटर करा',
          'otp_message': 'आम्ही ते नंबरवर पाठवले',
          'edit_number': 'क्रमांक संपादित करा',
          'resend_otp': 'OTP पुन्हा पाठवा',
          'invalid_otp': 'कृपया वैध OTP प्रविष्ट करा',
          'select_prefer_lan': 'पसंतीची भाषा निवडा',
          'loyalty_points': 'Loyalty points',
          'welcome': 'स्वागत आहे,',
          'cashback_india1_summary': 'India1 सारांश द्वारे कॅशबॅक',
          'in': 'मध्ये',
          'redeem_points_now': 'आता पॉइंट रिडीम करा',
          'home': 'मुख्यपृष्ठ',
          'payments': 'देयके',
          'loans': 'कर्ज',
          'insurance': 'विमा',
          'savings': 'बचत',
          // loan section
          'loan_categories': 'कर्ज देयके',
          'payment_categories': 'देयके',
          'insurance_categories': 'विमा ',

          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal Loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',
          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'other': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',
          // drop down

          'my_profile': 'प्रोफाइल',
          'my_rewards': 'पुरस्कार',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'Recharge',
          'fast_teg': 'FASTag',
          'dth': 'DTH',

          // Saving section

          'fixed_deposit': 'Fixed Deposit',
          'digi_gold': 'FD(Fixed Deposit)',
          'digi_silver': 'Digi Gold',

          'privacy_policy': 'गोपनीयता धोरण'
        },
        'te_IN': {
          'bank_accounts': 'बैंक खाते',

          //profile section
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_redeemed': 'Total redeemed:',
          'total_earned': 'कुल अर्जित अंक:',
          'cashback_summary': 'Cashback by India1 summary',
          'current_balance': 'Current balance',
          'hello': 'హలో వరల్డ్',
          'mobile_number': 'మొబైల్ నంబర్',
          'term_condition': 'నిబంధనలు & షరతులు',
          'i_accept': 'నేను ఒప్పుకుంటున్నా',
          'request_otp': 'OTPని అభ్యర్థించండి',
          'empty_error_msg': '*Please enter a valid 10 digit mobile number',
          'checkbox_select_error':
              'కొనసాగడానికి మా నిబంధనలు & షరతులను అంగీకరించండి',
          'sending_otp': 'OTPని పంపుతోంది',
          'proceed_btn': 'Proceed',
          'enter_otp': 'Enter OTP',
          'otp_message': 'నంబర్‌కి పంపించాం',
          'edit_number': 'సంఖ్యను సవరించండి',
          'resend_otp': 'OTP పంపు',
          'invalid_otp': 'దయచేసి చెల్లుబాటు అయ్యే OTPని నమోదు చేయండి',
          'select_prefer_lan': 'ప్రాధాన్య భాషని ఎంచుకోండి',
          'loyalty_points': 'Loyalty points',
          'welcome': 'స్వాగతం,',
          'cashback_india1_summary': 'ఇండియా1  ద్వారా క్యాష్‌బ్యాక్',
          'in': 'లో',
          'redeem_points_now': 'Redeem Points Now',
          'home': 'చేయండి',
          'payments': 'చేయండి',
          'loans': 'Loans',
          'insurance': 'చేయండి',
          'savings': 'చేయండి',
          'logout': 'చేయండ',

          // loan section
          'loan_categories': 'ఎంచుకోండి',
          'payment_categories': 'ఇండియా1',
          'insurance_categories': 'ఇండి',

          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal Loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',
          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'other': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',
          // drop down

          'my_profile': 'प्रोफाइल',
          'my_rewards': 'पुरस्कार',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'Recharge',
          'fast_teg': 'FASTag',
          'dth': 'DTH',

          // Saving section

          'fixed_deposit': 'Fixed Deposit',
          'digi_gold': 'FD(Fixed Deposit)',
          'digi_silver': 'Digi Gold',

          'privacy_policy': 'गोपनीयता नीति'
        },
        'ta_IN': {
          'bank_accounts': 'बैंक खाते',

          //profile section
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_redeemed': 'Total redeemed:',
          'total_earned': 'कुल अर्जित अंक:',
          'cashback_summary': 'Cashback by India1 summary',
          'current_balance': 'Current balance',
          'hello': 'வணக்கம் உலகம்',
          'mobile_number': 'ಮೊಬೈಲ್ ನಂಬರ',
          'term_condition': 'விதிமுறைகளும் நிபந்தனைகளும்',
          'i_accept': 'நான் ஏற்றுக்கொள்கிறேன்',
          'request_otp': 'OTP ஐக் கோரவும்',
          'empty_error_msg': '*Please enter a valid 10 digit mobile number',
          'checkbox_select_error':
              'தொடர எங்கள் விதிமுறைகள் மற்றும் நிபந்தனைகளை ஏற்கவும்',
          'sending_otp': 'OTP அனுப்புகிறது',
          'proceed_btn': 'Proceed',
          'enter_otp': 'Enter OTP',
          'otp_message': 'எண்ணுக்கு அனுப்பினோம்',
          'edit_number': 'எண்ணைத் திருத்து',
          'resend_otp': 'OTP அனுப்பவும்',
          'invalid_otp': 'சரியான OTP ஐ உள்ளிடவும்',
          'select_prefer_lan': 'மொழியைத் தேர்ந்தெடுக்கவும்',
          'loyalty_points': 'Loyalty points',
          'welcome': 'வரவேற்பு,',
          'cashback_india1_summary': 'இந்தியா 1 சுருக்கம்  கேஷ்பேக்',
          'in': '்ளே',
          'redeem_points_now': 'Redeem Points Now',
          'home': 'சுருக்ம்',
          'payments': 'சுருக்க',
          'loans': 'Loans',
          'insurance': 'சுருக்கம்',
          'savings': 'சுருக்',

          // loan section
          'loan_categories': 'மீட்டுக்கொள்ளு',
          'payment_categories': 'டுக்கொள்ளு',
          'insurance_categories': '்கொள்ளு',

          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',

          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal Loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',
          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'other': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',
          // drop down

          'my_profile': 'प्रोफाइल',
          'my_rewards': 'पुरस्कार',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'Recharge',
          'fast_teg': 'FASTag',
          'dth': 'DTH',

          // Saving section

          'fixed_deposit': 'Fixed Deposit',
          'digi_gold': 'FD(Fixed Deposit)',
          'digi_silver': 'Digi Gold',

          'privacy_policy': 'Privacy policy'
        },
        'mal_IN': {
          'Get_it_on_India1': 'ഇന്ത്യ 1 ൽ നേടുക',
          'Now_with_India1': 'ഇപ്പോൾ ഇന്ത്യ 1 ഉപയോഗിച്ച്',
          'When_with_India1': 'ഇന്ത്യ 1 ഉള്ളപ്പോൾ',

          'bank_accounts': 'ബാങ്ക് അക്കൗണ്ട്',
          'point': 'പോയിന്റ്',
          'loans_banner_text': 'വായ്പകൾക്കായി ചുറ്റിക്കറങ്ങേണ്ടതില്ല',
          'payment_banner_text': 'ഓരോ ഇടപാടിലും സമ്പാദിക്കുക',

          'insurance_banner_text': 'നിങ്ങളെയും നിങ്ങളുടെ  ഇൻഷ്വർ ചെയ്യുക',
          'saving_banner_text':
              'കൂടുതൽ ലാഭിക്കുന്നു, കൂടുതൽ നിങ്ങൾ സമ്പാദിക്കുന്നു',

          //profile section
          'no_first_name': 'ആദ്യ നാമം ഇല്ല',
          'no_last_name': 'അവസാന നാമം ഇല്ല',
          'no_number': 'നമ്പറില്ല',
          'no_email': 'ഇമെയിൽ ഐഡി ഇല്ല',
          'no_dob': 'ഡിഒബി ഇല്ല',
          'not_entered': 'നൽകിയിട്ടില്ല',
          'not_updated': 'അപ്ഡേറ്റ് ചെയ്തിട്ടില്ല',
          'add_persnl_details': 'വ്യക്തിഗത വിശദാംശങ്ങൾ നല്കുക',
          'add_residntl_details': 'വാസസ്ഥാന വിവരങ്ങൾ നല്കുക',
          'no_residntl_data': 'റെസിഡൻഷ്യൽ ഡാറ്റ കണ്ടെത്താൻ കഴിഞ്ഞില്ല!',
          'add_occupation_details': 'തൊഴിൽ വിശദാംശങ്ങൾ നല്കുക',
          'no_occupation_data':
              'നിങ്ങളുടെ തൊഴിൽ വിവരങ്ങൾ കണ്ടെത്താൻ കഴിഞ്ഞില്ല!',
          'bank_accounts': 'ബാങ്ക് അക്കൗണ്ടുകൾ',
          'no_bank_data':
              'സേവ് ചെയ്ത ബാങ്ക് അക്കൗണ്ട് വിശദാംശങ്ങളൊന്നും കണ്ടെത്താനായില്ല!',
          'add_bank_acc': 'ബാങ്ക് അക്കൗണ്ട് നല്കുക',
          'upi_id': 'യുപിഐ ഐഡി',
          'no_upi_data':
              'സംരക്ഷിച്ച യുപിഎ/വിപിഎ വിശദാംശങ്ങളൊന്നും കണ്ടെത്താനായില്ല!',
          'add_upi_id': 'യുപിഐ / വിപിഎ വിശദാംശങ്ങൾ നല്കുക',

          'earn_more_points': 'കൂടുതൽ പോയിന്റുകൾ നേടുക',
          'locate_atm': 'എടിഎം കണ്ടെത്തുക',
          'rewads_at_atm': 'റിവാർഡുകൾ',
          'find_nearest_atm': 'സമീപമുള്ള ഇന്ത്യ 1 ATM കണ്ടെത്തുക',
          'cashback': 'ക്യാഷ്ബാക്ക് ',

          'recharge': 'റീചാർജ്',
          'ways_to_reddem': 'റിഡീം വഴികൾ:',
          'total_redeemed': 'ആകെ  ചെയ്തത്',
          'total_earned': 'ആകെ നേടിയ:',
          'cashback_summary': 'ക്യാഷ്ബാക്ക് ബൈ ഇന്ത്യ 1- സംഗ്രഹം',
          'current_balance': 'നിലവിലെ ബാലൻസ്',
          'hello': 'ഹലോ വേൾഡ്',
          'mobile_number': 'മൊബൈൽ നമ്പർ',
          'term_condition': 'നിബന്ധനകളും വ്യവസ്ഥകളും',
          'i_accept': 'ഞാൻ അംഗീകരിക്കുന്നു',
          'request_otp': 'OTP അഭ്യർത്ഥിക്കുക',
          'empty_error_msg': '*ദയവായി സാധുവായ 10 അക്ക മൊബൈൽ നമ്പർ നൽകുക',
          'checkbox_select_error':
              'തുടരുന്നതിന് ഞങ്ങളുടെ നിബന്ധനകളും വ്യവസ്ഥകളും അംഗീകരിക്കുക',
          'sending_otp': 'OTP അയയ്ക്കുന്നു',
          'proceed_btn': 'തുടരുക',
          'enter_otp': 'OTP നൽകുക',
          'otp_message': 'ഞങ്ങൾ അത് നമ്പറിലേക്ക് അയച്ചു',
          'edit_number': 'നമ്പർ  ചെയ്യുക',
          'resend_otp': 'OTP അയയ്‌',
          'invalid_otp': 'ദയവായി സാധുവായ OTP നൽകുക',
          'select_prefer_lan': 'ഇഷ്ടപ്പെട്ട ഭാഷ തിരഞ്ഞെടുക്കുക',
          'loyalty_points': 'വിശ്വസ്തത ഒഴുകുന്നു',
          'welcome': 'സ്വാഗതം,',
          'cashback_india1_summary': 'ക്യാഷ്ബാക്ക് ബൈ ഇന്ത്യ1 സംഗ്രഹം',
          'in': 'in',
          'redeem_points_now': 'വീണ്ടെടുക്കുക',
          'home': 'ഹോം',
          'payments': 'പേയ്മെന്റുകൾ',
          'loans': 'വായ്പകൾ',
          'insurance': 'ഇൻഷുറൻസ്',
          'savings': 'സേവിംഗ്സ്',

          // loan section
          'loan_categories': 'തിരഞ്ഞെടുക്കുക',
          'payment_categories': 'ബൈ',
          'insurance_categories': 'ബൈ',

          'personal': 'വ്യക്തിഗതം',
          '2_wheeler': 'ഇരുചക്ര വാഹനം',
          'farm_eqp': 'കാർഷിക ഉപകരണങ്ങൾ',
          'track_based_loan': 'അടിസ്ഥാനമാക്കിയുള്ളത്',
          'gold': 'സ്വർണ്ണം',
          'emi_card': 'എമി കാർഡ്',
          'credit_card': 'ക്രെഡിറ്റ് കാർഡ്',
          'credit_score': 'क्ക്രെഡിറ്റ് സ്കോർ',
          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'അടുത്തത്',
          'personal_loan_header': 'വ്യക്തിഗത വായ്പ', // prsnl loan
          'gold_loan_header': 'സ്വർണ്ണ വായ്പ', // gold loan
          'bike_loan_header': 'ബൈക്ക് വായ്പ', // bike loan
          'farm_loan_header': 'കാർഷിക വായ്പ', //farm
          'trackBased_loan_header':
              'ട്രാക്ക് അടിസ്ഥാനമാക്കിയുള്ള വായ്പ', // trackbased

          // loan details
          'loan_amount_desc':
              'സ്ലൈഡർ ഉപയോഗിച്ച് ആവശ്യമായ വായ്പ തുക നൽകുക അല്ലെങ്കിൽ ടെക്സ്റ്റ് ഫീൽഡിൽ ടൈപ്പ് ചെയ്യുക', //done
          'track_based_loan_details_desc':
              'നിങ്ങൾക്ക് വായ്പ ആവശ്യമുള്ള ഉപ ഉൽപ്പന്നം തിരഞ്ഞെടുക്കുക',
          'farm_loan_details_desc':
              'നിങ്ങൾക്ക് വായ്പ ആവശ്യമുള്ള ഉൽപ്പന്നം തിരഞ്ഞെടുക്കുക',

          // loans => steppers headers
          'loan_amount_header': 'വായ്പാ തുക',
          'personal_header_stpr': 'വ്യക്തിഗതം',
          'residential_header_stpr': 'വാസസ്ഥലം',
          'occupational_header_stpr': 'തൊഴിൽ',
          'additional_header_stpr': 'അധികമായ',
          'loan_details_header_stpr': 'വായ്പ വിശദാംശങ്ങൾ',
          'personal_details': 'വ്യക്തിഗത വിശദാംശങ്ങൾ',
          'residential_details': 'താമസ വിവരങ്ങൾ',
          'occupation_details': 'തൊഴിൽ വിശദാംശങ്ങൾ',
          'additional_information': 'അധിക വിവരം',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*ഈ വിവരം നിർബന്ധമാണ്',
          'first_name_e': '* ആദ്യ നാമം നിർബന്ധമാണ്',
          'last_name_e': '* അവസാന നാമം നിർബന്ധമാണ്',
          'mobile_num_e': '*10 അക്ക മൊബൈൽ നമ്പർ നല്കുക',
          'email_id_e': '* ഇമെയിൽ ഐഡി നിർബന്ധമാണ്',
          'date_of_birth_e': "*ജനന തീയതി നിർബന്ധമാണ്",
          'maritial_status_e': 'വൈവാഹിക നില നിർബന്ധമാണ്',
          'pan_num_e': '* പാൻ നമ്പർ നിർബന്ധമാണ്',
          'ad_e': '* വിലാസം നിർബന്ധമാണ്',
          'pincode_e': '* പിൻകോഡ് പൂരിപ്പിക്കുക',

          // bottom sheet
          'want_to_proceed_quest': 'നിങ്ങൾക്ക് തുടരണോ?',
          'proceed_description':
              'നൽകിയിരിക്കുന്ന എല്ലാ വിശദാംശങ്ങളും ദയവായി സ്ഥിരീകരിക്കുക. ഇത് സമർപ്പിച്ചുകഴിഞ്ഞാൽ, വിശദാംശങ്ങൾ മാറ്റാൻ നിങ്ങളെ അനുവദിക്കില്ല.',
          'apply_loan': 'വായ്പയ്ക്ക് അപേക്ഷിക്കുക',

          //applied success
          'loan_application_submitted': 'വായ്പ അപേക്ഷ സമർപ്പിച്ചു!',
          'team_will_get_back': 'ഞങ്ങൾ തിരികെ ബന്ധപ്പെടുന്നതായിരിക്കും',

          //ask
          //denied success

          //select lender
          'select_lender': 'തുടരുന്നതിന് പണമിടപാടു സ്ഥാപനത്തെ തിരഞ്ഞെടുക്കുക',
          'loan_provider': 'വ്യക്തിഗത വായ്പ ദാതാവ്',
          'explore': 'ആരായുക',

          //choose lender
          'one_lender_select': 'പട്ടികയിൽ നിന്ന് ഒരു ദാതാവിനെ തിരഞ്ഞെടുക്കുക',
          'min_doc': 'കുറഞ്ഞ ഡോക്യുമെന്റേഷൻ',
          'paperless': 'പേപ്പർലെസ് പ്രോസസ്സ്',
          'max_amount': 'പരമാവധി തുക',
          'tenure': 'കാലാവധി',
          'interest': 'താൽപ്പര്യം/m',
          'view_details': 'വിശദാംശങ്ങൾ കാണുക',
          'apply': 'അപേക്ഷിക്കുക',

          //provider details
          'top_features': 'സവിശേഷതകൾ',
          'other_details': 'മറ്റ് വിശദാംശങ്ങൾ',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'സ്വർണ്ണ വായ്പ പ്രക്രിയ',
          // unique => bike loan
          'vehicle_loan_process': 'വാഹന വായ്പ പ്രക്രിയ',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'പേരിന്റെ ആദ്യഭാഗം',
          'enter_first_name': 'നിങ്ങളുടെ ആദ്യ നാമം നൽകുക',
          'last_name': 'പേരിന്റെ അവസാന ഭാഗം',
          'enter_last_name': 'നിങ്ങളുടെ അവസാന നാമം നൽകുക',
          'mobile_num': 'മൊബൈൽ നമ്പർ',
          'enter_mobile_num': 'മൊബൈൽ നമ്പർ നൽകുക',
          'alt_num': 'ഇതര മൊബൈൽ നമ്പർ',
          'enter_alt_num': 'ഇതര നമ്പർ നൽകുക',
          'email_id': 'ഇ-മെയിൽ ഐഡി',
          'enter_email_id': 'ഇമെയിൽ ഐഡി ഇവിടെ നൽകുക',
          //ask
          'date_of_birth': "ജനനത്തീയതി (Dd-Mm-Yyyy)",
          'gender': 'ലിംഗഭേദം',
          'male': 'പുരുഷൻ',
          'female': 'സ്ത്രീ',
          'other': 'മറ്റുള്ളവ',
          'maritial_status': 'വൈവാഹിക നില',
          'select_maritial_status': 'നിങ്ങളുടെ വൈവാഹിക നില തിരഞ്ഞെടുക്കുക',
          'select_option': 'ഒരു ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക',
          'married': 'വിവാഹിത(ൻ)',
          'unmarried': 'അവിവാഹിത(ൻ)',
          'widowed': 'വിധവ',

          //Residential Form
          'ad_line1': 'വിലാസം വരി 1',
          'ad_line1_h': 'വീട്ട് നമ്പർ,  ക്രോസ്, മുതലായവ',
          'ad_line2': 'വിലാസം വരി 2',
          'ad_line2_h': 'ഏരിയ, റോഡ്, ലാൻഡ്മാർക്ക് തുടങ്ങിയവ നൽകുക',
          'pincode': 'പിൻ കോഡ്',
          'enter_pincode': 'പിൻകോഡ് ഇവിടെ നൽകുക',
          'city': 'നഗരം: നഗരം കാണുന്നതിന് പിൻകോഡ്  നൽകുക',
          'state': 'സംസ്ഥാനം: സംസ്ഥാനത്തിനായുള്ള പിൻകോഡ് നൽകുക',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'തൊഴിൽ തരം',
          'employment_type_h': 'നിങ്ങളുടെ തൊഴിൽ തരം തിരഞ്ഞെടുക്കുക',
          'monthly_income': 'പ്രതിമാസ വരുമാനം',
          'salary_mode': 'ശമ്പളം കിട്ടുന്ന രീതി',
          'salary_mode_h':
              'നിങ്ങൾക്ക് എങ്ങനെ ശമ്പളം ലഭിക്കുന്നെന്ന് തിരഞ്ഞെടുക്കുക',
          'pan_num': 'പാൻ നമ്പർ',
          'pan_num_h': 'നിങ്ങളുടെ പാൻ നമ്പർ നൽകുക',

          //additional_info

          'months_residing_at': 'താമസിക്കുന്ന മാസങ്ങളുടെ എണ്ണം',
          'highest_qualification': 'ഏറ്റവും ഉയർന്ന യോഗ്യത',
          'comapany_name': 'കമ്പനി പേര്',
          'designation': 'പദവി',
          'work_exp': 'പ്രവർത്തന പരിചയം ',
          'office_add1': 'ഓഫീസ് വിലാസം ലൈൻ 1',
          'office_add2': 'ഓഫീസ് വിലാസം ലൈൻ 2',
          'office_add_h': 'വിലാസം',
          'netbanking_quest': 'നിങ്ങൾ നെറ്റ്ബാങ്കിംഗ് ഉപയോഗിക്കാറുണ്ടോ?',
          'yes': 'അതെ',
          'no': 'ഇല്ല',
          'existing_loans_quest': 'നിങ്ങൾക്ക് നിലവിൽ ഏതെങ്കിലും വായ്പയുണ്ടോ?',
          'active_existng_loans_num': 'സജീവ / നിലവിലുള്ള വായ്പകളുടെ എണ്ണം',

          //-----------------

          //bike loan unique
          'product': 'പ്രോഡക്ട്‌',
          'product_h': 'ഉൽപ്പന്നം തിരഞ്ഞെടുക്കുക',
          'model': 'മോഡൽ',
          'model_h': 'മോഡൽ തിരഞ്ഞെടുക്കുക',

          //track_based_unique
          'sub_product': 'ഉപ ഉൽപ്പന്നം',
          'sub_product_h': 'ഉപ ഉൽപ്പന്നം തിരഞ്ഞെടുക്കുക',

          //farm loan unique
          'loan_requirement': 'വായ്പ ആവശ്യകത',
          'loan_requirement_h': 'വായ്പയ്ക്കുള്ള ഓപ്ഷൻ തിരഞ്ഞെടുക്കുക',
          'loan_requirement_e': '* തുടരുന്നതിന് ഇത് നിർബന്ധമാണ്',
          // drop down

          'my_profile': 'പ്രൊഫൈൽ',
          'my_rewards': 'റിവാർഡുകൾ',

          // insurance section text
          '4_wheeler': '4 വീലർ',
          'critical_illness': 'ഗുരുതരമായ രോഗം',

          //payments section

          'recharge': 'റീചാർജ്',
          'fast_teg': 'ഫാസ്റ്റ്ടാഗ്',
          'dth': 'ഡി.ടി.എച്ച്',

          // Saving section

          'fixed_deposit': 'സ്ഥിര നിക്ഷേപം',
          'digi_gold': 'FD (സ്ഥിര നിക്ഷേപം)',
          'digi_silver': 'ഡിജി ഗോൾഡ്',

          'privacy_policy': 'സ്വകാര്യതാ നയം'
        },
        'ban_IN': {
          'bank_accounts': 'बैंक खाते',

          //profile section
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_redeemed': 'Total redeemed:',
          'total_earned': 'कुल अर्जित अंक:',
          'cashback_summary': 'Cashback by India1 summary',
          'current_balance': 'Current balance',
          'hello': 'হ্যালো',
          'mobile_number': 'মোবাইল নম্বর',
          'term_condition': 'শর্তাবলী',
          'i_accept': 'আমি স্বীকার করছি',
          'request_otp': 'অনুরোধ otp',
          'empty_error_msg': '*Please enter a valid 10 digit mobile number',
          'checkbox_select_error':
              'এগিয়ে যাওয়ার জন্য আমাদের শর্তাবলীতে সম্মত হন',
          'sending_otp': 'OTP পাঠানো হচ্ছে',
          'proceed_btn': 'Proceed',
          'enter_otp': 'Enter OTP',
          'otp_message': 'আমরা নাম্বারে পাঠিয়ে দিলাম',
          'edit_number': 'নম্বর সম্পাদনা করুন',
          'resend_otp': 'OTP আবার পাঠান',
          'invalid_otp': 'অনুগ্রহ করে বৈধ ওটিপি লিখুন',
          'select_prefer_lan': 'পছন্দের ভাষা নির্বাচন করুন',
          'loyalty_points': 'Loyalty points',
          'welcome': 'স্বাগত,',
          'cashback_india1_summary': 'India1 সারাংশ দ্বারা ক্যাশব্যাক',
          'in': 'ভিতরে',
          'redeem_points_now': 'পয়েন্ট রিডিম করুন',
          'home': 'Home',
          'payments': 'Payments',
          'loans': 'Loans',
          'insurance': 'Insurance',
          'savings': 'Savings',

          // loan section
          'loan_categories': 'পছন্দের ভাষা',
          'payment_categories': 'ভাষা',
          'insurance_categories': 'পছন্দের',

          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',
          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal Loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',
          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'other': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',
          // drop down

          'my_profile': 'प्रोफाइल',
          'my_rewards': 'पुरस्कार',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'Recharge',
          'fast_teg': 'FASTag',
          'dth': 'DTH',

          // Saving section

          'fixed_deposit': 'Fixed Deposit',
          'digi_gold': 'FD(Fixed Deposit)',
          'digi_silver': 'Digi Gold',

          'privacy_policy': 'Privacy policy'
        },
        'or_IN': {
          'bank_accounts': 'बैंक खाते',

          //profile section
          'no_first_name': 'No First Name',
          'no_last_name': 'No Last Name',
          'no_number': 'No Number',
          'no_email': 'No Email Id',
          'no_dob': 'No Dob',
          'not_entered': 'Not Entered',
          'not_updated': 'Not Updated',
          'add_persnl_details': 'Add Personal Details',
          'add_residntl_details': 'Add Residental Details',
          'no_residntl_data': 'Could Not Find Any Residential Data!',
          'add_occupation_details': 'Add Occupation Details',
          'no_occupation_data':
              'Could Not Find Any Of Your Occupation Details!',
          'bank_accounts': 'Bank Account(S)',
          'no_bank_data': 'Could Not Find Any Saved Bank Account Details!',
          'add_bank_acc': 'Add Bank Account',
          'upi_id': 'Upi Id(S) / Vpa Number(S)',
          'no_upi_data': 'Could Not Find Any Saved Upi / Vpa Details!',
          'add_upi_id': 'Add Upi / Vpa Details',
          'earn_more_points': 'अधिक अंक अर्जित करें',
          'locate_atm': 'Locate ATM',
          'rewads_at_atm': 'rewards at ATMs',
          'find_nearest_atm': 'Find the nearest India1 ATM',
          'cashback': 'Cashback',

          'recharge': 'रिचार्ज',
          'ways_to_reddem': 'भुनाने के तरीके:',
          'total_earned': 'कुल अर्जित अंक:',
          'total_redeemed': 'Total redeemed:',
          'cashback_summary': 'Cashback by India1 summary',
          'current_balance': 'ସାମ୍ପ୍ରତିକ ସନ୍ତୁଳନ',
          'hello': ' ନମ୍ବର',
          'mobile_number': 'ମୋବାଇଲ୍ ନମ୍ବର',
          'term_condition': 'Terms & Conditions',
          'i_accept': 'ମୁଁ ସର୍ତ୍ତ ଏବଂ ସର୍ତ୍ତଗୁଡିକ ଗ୍ରହଣ କରେ',
          'request_otp': 'OTP ଅନୁରୋଧ',
          'empty_error_msg':
              '*ଦୟାକରି ଏକ ବ valid ଧ 10-ଅଙ୍କ ବିଶିଷ୍ଟ ମୋବାଇଲ୍ ନମ୍ବର ପ୍ରବେଶ କରନ୍ତୁ',
          'checkbox_select_error': 'ଆଗକୁ ବ to ିବା ପାଇଁ ଆମର ଚୁକ୍ତିନାମାକୁ ସହମତ |',
          'sending_otp': 'OTP ପଠାଉଛି',
          'proceed_btn': 'ଅଗ୍ରଗତି କର',
          'enter_otp': 'OTP ପ୍ରବେଶ କରନ୍ତୁ',
          'otp_message': 'ଆମେ ଏହାକୁ ନମ୍ବରକୁ ପଠାଇଲୁ |',
          'edit_number': 'ସଂଖ୍ୟା ସଂପାଦନ କରନ୍ତୁ |',
          'resend_otp': 'OTP ପଠାନ୍ତୁ |',
          'invalid_otp': 'ଦୟାକରି ବ valid ଧ OTP ପ୍ରବେଶ କରନ୍ତୁ |',
          'select_prefer_lan': 'ପସନ୍ଦିତ ଭାଷା ଚୟନ କରନ୍ତୁ',
          'loyalty_points': 'Loyalty points',
          'welcome': 'ସ୍ୱାଗତ,',
          'cashback_india1_summary': 'ଭାରତ 1 ସାରାଂଶ ଦ୍ୱାରା କ୍ୟାସବ୍ୟାକ୍',
          'cashback_summary': 'ଭାରତ 1 ସାରାଂଶ ଦ୍ୱାରା କ୍ୟାସବ୍ୟାକ୍',
          'in': 'ଭିତରେ',
          'redeem_points_now': 'ପଏଣ୍ଟଗୁଡିକ ବର୍ତ୍ତମାନ ମୁକ୍ତ କରନ୍ତୁ',
          'home': 'କରନ୍ତୁ',
          'payments': 'କରନ୍ତୁ',
          'loans': 'ଋଣ',
          'insurance': 'କରନ୍ତୁ',
          'savings': 'ସଞ୍ଚୟ',

          // loan section
          'loan_categories': 'ପଏଣ୍ଟଗୁଡିକ',
          'payment_categories': 'ପଏଣ୍ଟଗୁଡିକ',
          'insurance_categories': 'ପଏଣ୍ଟଗୁଡିକ',

          'personal': 'निजी',
          '2_wheeler': '2 व्हीलर',
          'farm_eqp': 'फार्म ईक्यूपी',
          'track_based_loan': 'ट्रैक  ऋण',
          'gold': 'सोना',
          'emi_card': 'ईएमआई कार्ड',
          'credit_card': 'क्रेडिट कार्ड',
          'credit_score': 'क्रेडिट अंक',

          // drop down

          'my_profile': 'ପଏଣ୍ଟଗୁଡିକ',
          'my_rewards': 'ମୁକ୍ତ',
          //loans => Commmon Headers and texts like all stepper things
          'next_button': 'Next',
          'personal_loan_header': 'Personal Loan', // prsnl loan
          'gold_loan_header': 'Gold Loan', // gold loan
          'bike_loan_header': 'Bike Loan', // bike loan
          'farm_loan_header': 'Farm Loan', //farm
          'trackBased_loan_header': 'Track based Loan', // trackbased

          // loan details
          'loan_amount_desc':
              'Enter The Loan Amount Required Using The Slider Or Type In The Text Field', //done
          'track_based_loan_details_desc':
              'Choose The Sub-Product For Which You Want The Loan',
          'farm_loan_details_desc':
              'Choose The Product Against Which You Want The Loan',

          // loans => steppers headers
          'loan_amount_header': 'Loan Amount',
          'personal_header_stpr': 'Personal',
          'residential_header_stpr': 'Residential',
          'occupational_header_stpr': 'Occupation',
          'additional_header_stpr': 'Additional',
          'loan_details_header_stpr': 'Loan Details',
          'personal_details': 'Personal Details',
          'residential_details': 'Residential Details',
          'occupation_details': 'Occupation Details',
          'additional_information': 'Additional Information',

          //All  --> errors
          //no errors for additional info
          'this_field_mandatory': '*This Field Is Mandatory',
          'first_name_e': '*First Name Is Mandatory',
          'last_name_e': '*Last Name Is Mandatory',
          'mobile_num_e': '*Mobile Number Should Be 10 Digits',
          'email_id_e': '*Email Id Is Mandatory',
          'date_of_birth_e': "*Date Of Birth Is Mandatory",
          'maritial_status_e': 'Marital Status Is Mandatory',
          'pan_num_e': '*Pan Number Is Mandatory',
          'ad_e': '*Address Is Mandatory',
          'pincode_e': '*Pincode Needs To Be Filled',

          // bottom sheet
          'want_to_proceed_quest': 'Do You Want To Proceed?',
          'proceed_description':
              'Please Verify All The Details Provided. Once It Is Submitted, You Will Not Be Allowed To Change The Details.',
          'apply_loan': 'Apply For Loan',

          //applied success
          'loan_application_submitted': 'Loan Application Submitted!',
          'team_will_get_back': 'The Team Will Get Back To You.',

          //ask
          //denied success

          //select lender
          'select_lender': 'Select The Lender To Proceed',
          'loan_provider': 'Personal Loan Provider',
          'explore': 'Explore',

          //choose lender
          'one_lender_select': 'Choose One Lender From The List',
          'min_doc': 'Minimum Documentation',
          'paperless': 'Paperless Process',
          'max_amount': 'Max Amount',
          'tenure': 'Tenure',
          'interest': 'Interest/M',
          'view_details': 'View Details',
          'apply': 'Apply',

          //provider details
          'top_features': 'Top Features',
          'other_details': 'Other Details',
          'interest_rate': '',
          'max_age': '',
          'min_age': '',
          'loan_tenure': '',
          'apply_now': '',
          // unique=> gold loan
          'gold_loan_process': 'Gold loan process',
          // unique => bike loan
          'vehicle_loan_process': 'Vehicle loan process',
          //-----------------
          //All Forms
          //Personal Details form

          'first_name': 'First Name',
          'enter_first_name': 'Enter Your First Name',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Your Last Name',
          'mobile_num': 'Mobile Number',
          'enter_mobile_num': 'Enter mobile number',
          'alt_num': 'Alternate Number',
          'enter_alt_num': 'Enter alternate number',
          'email_id': 'Email Id',
          'enter_email_id': 'Enter Email Id Here',
          //ask
          'date_of_birth': "Date Of Birth (Dd-Mm-Yyyy)",
          'gender': 'Gender',
          'male': 'Male',
          'female': 'Female',
          'other': 'Other',
          'maritial_status': 'Marital Status',
          'select_maritial_status': 'Select Your Marital Status',
          'select_option': 'Select An Option',
          'married': 'Married',
          'unmarried': 'Unmarried',
          'widowed': 'Widowed',

          //Residential Form
          'ad_line1': 'Address Line 1',
          'ad_line1_h': 'Enter Door No, Cross, Etc',
          'ad_line2': 'Address Line 2',
          'ad_line2_h': 'Enter Area, Road, Landmark, Etc',
          'pincode': 'Pincode',
          'enter_pincode': 'Enter Pincode Here',
          'city': 'City : Enter Pincode To View City',
          'state': 'State : Enter Pincode To View State',

          //occcupation Form
          //ask
          //show ui and doc (drop downs)

          'employment_type': 'Employment Type',
          'employment_type_h': 'Choose Your Employment Type',
          'monthly_income': 'Monthly Income',
          'salary_mode': 'Salary Mode',
          'salary_mode_h': 'Choose How You Receive Salary',
          'pan_num': 'Pan Number',
          'pan_num_h': 'Enter Your Pan Number',

          //additional_info

          'months_residing_at': 'No. Of Months Residing At',
          'highest_qualification': 'Highest Qualification',
          'comapany_name': 'Company Name',
          'designation': 'Designation',
          'work_exp': 'Work Experience',
          'office_add1': 'Office Address Line 1',
          'office_add2': 'Office Address Line 2',
          'office_add_h': 'Address',
          'netbanking_quest': 'Do You Use Netbanking?',
          'yes': 'Yes',
          'no': 'No',
          'existing_loans_quest': 'Do You Have Any Existing Loan?',
          'active_existng_loans_num': 'No. Of Active / Existing Loans',

          //-----------------

          //bike loan unique
          'product': 'Product',
          'product_h': 'Select A Product',
          'model': 'Model',
          'model_h': 'Select A Model',

          //track_based_unique
          'sub_product': 'Sub Product',
          'sub_product_h': 'Select Sub Product',

          //farm loan unique
          'loan_requirement': 'Loan Requirement',
          'loan_requirement_h': 'Choose The Option For Loan',
          'loan_requirement_e': '*This Is Mandatory To Proceed',

          // insurance section text
          '4_wheeler': '4 व्हीलर',
          'critical_illness': 'गंभीर बीमारी',

          //payments section

          'recharge': 'ପଏଣ୍ଟଗୁଡିକ',
          'fast_teg': 'ପଏଣ୍ଟଗୁଡିକ',
          'dth': 'ପଏଣ',

          // Saving section

          'fixed_deposit': 'ପଏଣ୍ଟଗୁଡିକ',
          'digi_gold': 'ପଏଣ୍ଟଗୁଡିକ',
          'digi_silver': 'ପଏଣ୍ୁଡିକ',

          'privacy_policy': 'Privacy policy'
        },
      };
}
