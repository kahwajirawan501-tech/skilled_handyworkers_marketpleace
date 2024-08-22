

import 'package:get/get_navigation/src/root/internacionalization.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "ar": {
      //splash
      "1": "قدم لنا",
      "2": " وظيفة أحلامك",
      "3": "هنا !",
      "4": "قدم جميع الأدوار الوظيفية الأكثر إثارة بناء على اهتمامك وتخصصك الدراسي.",
      //login
      "5": "الايميل",
      "6": "كلمة السر",
      "7": "هل نسيت كلمة السر ؟",
      "8": " تسجيل الدخول",
      "9": "  تسجيل الدخول عن طريق غوغل ",
      "10": "ليس لديك حساب حتى الآن؟ ",
      "11": " التسجيل ",
      "12": "اهلا بك مجددا",
      //sign up
      "13": "إنشاء حساب ",
      "14": "الاسم الكامل",
      //forgot pass
      "15": "لإعادة تعيين كلمة المرور الخاصة بك ، تحتاج إلى بريدك الإلكتروني المحمول الذي يمكن مصادقته ",
      "16": ' إعادة تعيين كلمة المرور ',
      "17": "العودة إلى تسجيل الدخول",
      "18": "ارسل الرمز",
      // Check Your Email
      "19": "تحقق من بريدك الإلكتروني  ",
      "20": "لقد أرسلنا إعادة تعيين كلمة المرور إلى عنوان البريد الإلكتروني brandonelouis@gmial.com",
      "21": "تأكيد",
      "22":"لم تتلق البريد الإلكتروني؟",
      "23": "اعادة ارسال",
      "24": "أدخل الرمز",
      //Successfully
      "25": "نجاح",
      "26": "تم تحديث كلمة المرور الخاصة بك ، يرجى تغيير كلمة المرور الخاصة بك بانتظام لتجنب حدوث ذلك",
      "27": "أدخل كلمة المرور الجديدة:",
      "28": "التأكيد من كلمة المرور الجديدة",
      //
      "29": "كلمة مرور جديدة",
      "30": "تأكيد كلمة المرور",
      // Add Posting`
      "31": " تم نشر المنشور بنجاح ",
      "32": "لم يتم نشر المنشور بنجاح",
      "33": "يجب عليك ملأ حقل الخدمة وحقل المنطقة و حقل الوصف",//You must fill in the service field and the location field and the description file
      "34": "منشور",//post
      "35": "إضافة منشور",//Add post
      "36": " نوع الخدمة ",// Service Type
      "37": "إضافة خدمة",//Add Service
      "38": "البحث",//Search
      "39": "إختيار خدمة",//Select service
      "40": "المنطقة ",// Location
      "41": "أختيار منطقة ",//Select location
      "42": " إضافة سؤال ",// Add Question
      "43": "أضف سؤالك ... ",//add your question ...
      "44": "تم تجاوز الحد",//Limit Exceeded
      "45": "مكنك أختيار ما يصل إلى ",//You can select up to
      "46": "صور أخرى",// more images.
      "47": " نعم ",//OK
      "48": "أختيار من المعرض",//Choose from Gallery
      "49": " أخذ صور ",//Take Photo
      "50": "صور :",//Image :
      "51": "تسجيل فيديو",//Record Video
      "52": "فيديو أخر",// more videos.
      "53": "فيديو :",//Video :
      "54": "خطأ !! ,عند تحميل الفيديو و الصور",//error !! , when upload image and video
      "55": "يجب عليك ملأ حقل الخدمة و حقل المنطقة و أختيار الفيديوهات او الصور الذي تريد نشره",
//You must fill in the service field and the location field and choose the videos or photos that you want to publish
      "56": "يجب عليك ملأ حقل الخدمة و أختيار الفيديوهات او الصور الذي تريد نشره ",
//You must fill in the service field  and  choose the videos or photos that you want to publish
      "57": "يجب عليك ملأ حقل المنطقة و أختيار الفيديوهات او الصور الذي تريد نشره",
//You must fill in the location field  and  choose the videos or photos that you want to publish
      "58": "أختيار الفيديوهات او الصور الذي تريد نشره",
//choose the videos or photos that you want to publish
      "59": "منشور",//post
      "60": "إضافة الوصف ",//Add Description
      "61": "إضافة وصفك .. ",//add your description ..
      "62": "من فضلك أختر الخدمة و المنطقة أولا ",//Please select service and location first
      "63": "إضافة صور و فيديو",// Add Image or Video
      // BottomNavigationScreen
      "64": "ما الذي تود أن تضيفه ؟",//What would you like to add?
      "65": "نشر منشور أو إضافة سؤال ؟",//publish a post or an open question?
      "66": "منشور",//Post
      "67": "سؤال مفتوح",//Open Question
      //ChatList
      "68": "رسائل",//Messages
      "69": "البحث",//Search
      //Messages
      "70": "حذف",//Delete
      "71": "تعديل",//Edit
      "72": "الرسالة لم ترسل بنجاح",//The message hasn't been send successfully
      "73": "الرسالة لم تعدل بنجاح",//The message hasn't been edit successfully
      "74": "متصل",//Online
      "75": "غير متصل",//Offline
      "76": "لا يوجد رسائل",//No messages
      "77": "أكتب رسالتك ... ",//Write your message...
      //No Messages
      "78": "ليس لديك حاليا أي رسالة واردة",//You currently have no incoming message
      "79": "شكرا لك ",// thank you
      //CommitScreen
      "80": "الرد على",//Replying to :
      "81": "التعليق لم يحذف بنجاح",//The commit hasn't been delete successfully
      "82": "التعليق لم يعدل بنجاح",//The commit hasn't been edit successfully
      "83": "لتعليق لم يضاف بنجاح",//The commit hasn't been add successfully
      "84": "لا يوجد تعليق بعد .كن أول المعلقين ",//No comments yet. Be the first to comment!
      "85": "الرد",//Reply
      "86": "أكتب ردك ... ",//Write your reply...
      "87": "أكتب رسالتك ... ",//Write your message...
      //EditPost
      "88": "لخطأ!",//Error!
      "89": "المنشور حدث بنجاح :",//The post has been update successfully
      "90": "المنشور لم يحدث بنجاح",//The post hasn't been update successfully
      "91": "تحديث",//update
      "92": "تعديل المنشور",//Edit Post
      "93": "تعديل السؤال ",// Edit Question
      "94": "تعديل سؤالك ... ",//Edit your question ...
      "95": "تعديل الوصف ",// Edit Description
      "96": "تعديل وصفك .. ",//Edit your description ..
      "97": "ساعات",// Add Image or Video
      //HomeScreen
      "98": "مرحبا",//Hello
      "99": "إيجاد خدمة ",//Find the Servic
      "100": "التي تريد",
      "101": "أبحث الأن ",//Search Now
      //information
      "102": "رؤية المزيد",//See More
      "103": "منشورات",//posting
      "104": "أسئلة مفتوحة",//open question
      "105": "الاسم كامل",//Full Name
      "106": "حولي",//About me
      "107": "رقم الهاتف",//Phone Number
      "108": "الجنس",//Gender
      "109": "المهارة ",//Skill
      "110": "الموقع",//Location
      "111": "خبرات العمل",//Work experience
      "112": "تعليم",//Education
      //posting
      "113": "لا يوجد منشور بعد",//Not Post Yet
      "114": "تم حذف المنشور بنجاح",//The post has been delete successfully
      "115": "لم يتم حذف المنشور بنجاح",//The post hasn't been delete successfully
      "116": "لم يتم نشر سؤال المفتوح بعد",//Not openQuestion Yet
      //profile
      "117": "م الاضافة بنجاح",//Adding successfully
      "118": "لم يتم الاضافة بنجاح",//Adding not successfully
      "119": "تم تعديل بنجاح",//Editing successfully
      "120": "لم يتم التعديل بنجاح",//Editing not successfully
      "121": "حولي",//About me
      "122": "أخبرنا عنك ",//Tell me about you.
      "123": "التراجع عن التغيير ؟",//Undo Changes ?
      "124": "هل انت متأكد التغيير ألى الذي أدخلته؟",//Are you sure you want to change what you entered?
      "125": "الاستمرار بالمدخل",//Continue Filling
      "126": "التراجع عن التغيير",//Undo Changes
      "127": "حفظ",//Save
      "128": "إضافة تعليم ",//Add Education
      "129": "اسم الدراسة",//Institution name
      "130": " الوصف",//Description
      "131": "إكتب معلومات إضافية هنا",//Write additional information here
      "132": "حفظ",//Save
      "133": "اللغة",//Language
      "200": "عربي",//Arabic
      "201": "انكليزي",//English
      "202": "خطأ",//error
      "203": "تحديث كلمة السر",//Update Password
      '300': 'كلمة السر القديمة',//Old Password"
      "301": 'كلمة سر الجديدة',//New Password
      '302': 'من فضلك ادخل',//please enter the
      '303': 'تحديث',//Update
      '304': 'الضبط',//Settings
      '305': 'أشعارات',//Notification
      '306': 'وضع الدارك',//Dark mode
      '307': 'كلمة السر',//Password
      '308': 'تسجيل خروج',//Logout
      '309': 'هل انت متأكد أنك تريد المغادرة ؟',//Are you sure you want to leave?
      '311': 'نعم',//Yes
      '312': 'إلغاء',//Cancel
      '313': 'إضافة خبرات العمل',//Add work experience
      '314': 'عنوان العمل',//Job title
      '315': 'تعديل ملف شخصي',//Edit Profile
      '316': ' أضافة الصورة الشخصية لم تتم بنجاح',//Adding image profile not successfully
      '317': 'تم التعديل بنجاح',//Editing successfully
      '318': 'لم يتم الإضافة بنجاح',//Editing not successfully
      '319': 'تغيير الصورة',//Change image
      '320': 'الأسم كامل',//Full name
      '321': 'تاريخ الميلاد ',//Date of birth
      '322': 'ذكر',//Male
      '323': 'أنثى',//Female
      '324': 'البريد الألكتروني',//Email address
      '325': 'أختيار الصورة من المعرض أم ألتقاط صورة ؟',// choose the picture from the Gallery or Camera ?
      '326': 'من المعرض',//From Gallery
      '327': 'من الكميرا',//From Camera
      '328': ' المنشورات المحفوظة',//Save Post
      //Search Model
      '329': ' البحث عن منطقة',//Search location
      '330': 'لايوجد منطقة بهذا الاسم',//There is no area with this name
      '331': 'إضافة منطقة ',//Add Location
      '332': 'تم',//Done
      '333': 'لايوجد خدمة بهذا الاسم',//There is no service with this name
      '334': " إضافة خدمة",//Add Service
      '335': 'من فضلك أختر منطقة او الخدمة أولا',//Please select service or location first
      '336': 'الآن',//now
      '337': 'منذ دقيقة واحدة',//1 minute ago
      '338': 'منذ دقيقتين',
      '339': 'دقائق',
      '340': 'منذ',
      '341':'دقيقة',
      '342':'منذ ساعة واحدة ',
      '343':'منذ ساعتين',
      '344':'ساعات',
      '345':'ساعة',
      '346':'أمس الساعة',
      '347':'ع',
      '348':'نشر',
      '349':'تم تغيير كلمة السر بنجاح',
  '350':'رؤية المزيد',
      '351':'إيجاد شخص',
      '352':'كل الاسئلة المفتوحة ',
        '353':'كل المنشورات',
      '354':'إيجاد شخص',
      '355':'لا يوجد مستخدم',
      '356':'من اجل الاستفادة من إضافة منشور يجب عليك الذهاب إلى الملف الشخصي وأختيار الدور ',
  "357": "نشر  سؤال ؟",//publish a post or an open question?
      '358':"Role",
      '359':"customer",
      '360':"service provider"
    },
    "en": {
  //splash
      "1": "present Your",
      "2": "Dream Job",
      "3": "Here!",
      "4": "present all the most exciting job roles based on your interest and study major.",
      //login
      "5": "Email",
      "6": "password",
      "7": "Forget password ?",
      "8": "Login",
      "9": " Sign in with Google",
      "10": " You don't have an account yet? ",
      "11": "  Sign up",
      "12": "Welcome Back",
      //sign up
      "13": "Create an Account",
      "14": "Full name",
      //forgot pass
      "15": "To reset your password, you need your email  that can be authenticated",
      "16": 'Reset Password',
      "17": "Back to Login",
      "18": "Send code",
      // Check Your Email
      "19": "Check Your Email ",
      "20": "We have sent the reset password to the email address brandonelouis@gmial.com",
      "21": "Confirm",
      "22":"You have not received the email?",
      "23": "Resend",
      "24": "Enter your code",
      //Successfully
      "25": "Successfully",
      "26": "Your password has been updated, please change your password regularly to avoid this happening",
      "27": "Enter your new password:",
      "28": "confirm from your new password",
      //
      "29": "New password",
      "30": "Confirm password",
      //Add Post
      "31": "The post has been published successfully",
      "32": "The post hasn't been published successfully",
      "33": "You must fill in the service field and the location field and the description file ",
      "34": "post",
      "35": "Add Post",
      "36": "Service Type",
      "37": "Add Service",
      "38": "Search",
      "39": "Select service",
      "40": " Location",
      "41": "Select location",
      "42": " Add Question ",
      "43": "add your question ...",
      "44": "Limit Exceeded",
      "45": "You can select up to ",
      "46": " more images.",
      "47": "Ok",
      "48": "Choose from Gallery",
      "49": "Take Photo",
      "50": "Image :",
      "51": "Record Video",
      "52": "more videos.",
      "53": "Video :",
      "54": "error !! , when upload image and video ",
      "55": "You must fill in the service field and the location field and choose the videos or photos that you want to publish",
      "56": "You must fill in the service field  and  choose the videos or photos that you want to publish",
      "57": "You must fill in the location field  and  choose the videos or photos that you want to publish",
      "58": "choose the videos or photos that you want to publish",
      "59": "post",
      "60": "Add Description",
      "61": "add your description ..",
      "62": "Please select service and location first",
      "63": "Add Image or Video ",
  ///////////////////////////////////////////////////////////////////////////////////
      //BottomNavigationScreen
      "64": "What would you like to add?",
      "65": "publish a post or an open question?",
      "66": "Post",
      "67": "Open Question",
      //ChatList
      "68": "Messages",
      "69": "Search",
      //Messages
      "70": "Delete",
      "71": "Edit",
      "72": "The message hasn't been send successfully ",
      "73": "The message hasn't been edit successfully ",
      "74": "Online",
      "75": "Offline",
      "76": "No messages",
      "77": "Write your message...",
      //No Messages
      "78": "You currently have no incoming message",
      "79": " thank you",
      //CommitScreen
      "80": "Replying to :",
      "81": "The commit hasn't been delete successfully ",
      "82": "The commit hasn't been edit successfully ",
      "83": "The commit hasn't been add successfully ",
      "84": "No comments yet. Be the first to comment!",
      "85": "Reply",
      "86": "Write your reply...",
      "87": "Write your message...",
      //EditPost
      "88": "Error!",
      "89": "The post has been update successfully",
      "90": "The post hasn't been update successfully",
      "91": "update",
      "92": "Edit Post",
      "93": " Edit Question ",
      "94": "Edit your question ...",
      "95": " Edit Description ",
      "96": "Edit your description ..",
      "97": " Add Image or Video ",
      //HomeScreen
      "98": "Hello",
      "99": "Find the Service ",
      "100": "you need",
      "101": "Search Now",
      //information
      "102": "See More",
      "103": "posting",
      "104": "open question",
      "105": "Full Name",
      "106": "About me",
      "107": "Phone Number",
      "108": "Gender",
      "109": "Skill",
      "110": "Location",
      "111": "Work experience",
      "112": "Education",
     // Education
      "113": "Not Post Yet",
      "114": "The post has been delete successfully ",
      "115": "The post hasn't been delete successfully ",
      "116": "Not openQuestion Yet",
      //profile
      "117": "Adding successfully",
      "118": "Adding not successfully",
      "119": "Editing successfully",
      "120": "Editing not successfully ",
      "121": "About me",
      "122": "Tell me about you.",
      "123": "Undo Changes ?",
      "124": "Are you sure you want to change what you entered?",
      "125": "Continue Filling",
      "126": "Undo Changes",
      "127": "Save",
      "128": "Add Education",
      "129": "Institution name",
      "130": "Description",
      "131": "Write additional information here",
      "132": "Save",
      "133": "Language",
      "200": "Arabic",
      "201": "English",
      "202": "error",
      "203": "Update Password",
      "300": 'Old Password',
      '301': 'New Password',
      '302': 'please enter the ',
      '303': 'Update',
      '304': 'Settings',
      '305': 'Notification',
      '306': 'Dark mode',
      '307': 'Password',
      '308': 'Logout',
      '309': 'Are you sure you want to leave?',
      '311': 'Yes',
      '312': 'Cancel',
      '313': 'Add work experience',
      '314': 'Job title',
      '315': 'Edit Profile',
      '316': 'Adding image profile not successfully ',
      '317': 'Editing successfully',
      '318': 'Editing not successfully ',
      '319': 'Change image',
      '320': 'Full name',
      '321': 'Date of birth',
      '322': 'Male',
      '323': 'Female',
      '324': 'Email address',
      '325': ' choose the picture from the Gallery or Camera ? ',
      '326': 'From Gallery',
      '327': 'From Camera',
      '328': 'Save Post',
      //Search Model
      '329': 'Search location',
      '330': 'There is no area with this name',
      '331': 'Add Location',
      '332': 'Done',
      '333': 'There is no service with this name',
      '334': 'Add Service',
      '335': 'Please select service or location first',
      '336': 'now',
      '337': '1 minute ago',
      '338': '2 minute ago',
      '339': 'minutes',
      '340': 'ago',
      '341':'minute',
      '342':'1 hour ago',
      '343':'2 hour ago',
      '344':'hours',
      '345':'hour',
      '346':'yesterday hour',
      '347':'E',
      '348':'post',
       '349':'the password editing sucsessful',
  '350':'Find More',
      '351':'Find Person',
      '352':'All Open Question',
        '353':'All Post',
      '354':'Find User',
      '355':'Not Found User.',
      '356':'In order to benefit from adding a post, you must go to the profile and choose the role',
      "357": "publish an open question?",//publish a post or an open question?
      '358':"Role",
      '359':"customer",
      '360':"service provider"

    }
  };
}
