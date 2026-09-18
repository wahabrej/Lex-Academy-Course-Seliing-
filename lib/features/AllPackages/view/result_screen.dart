import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _selectedTab = 0; // 0 = Result, 1 = Merit List, 2 = Details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Result'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- ট্যাব রো ----------------
                  Row(
                    children: [
                      _buildTabChip('Result', 0),
                      SizedBox(width: 8.w),
                      _buildTabChip('Merit List', 1),
                      SizedBox(width: 8.w),
                      _buildTabChip('Details', 2),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ---------------- ট্যাব কন্টেন্ট ----------------
                  if (_selectedTab == 0) _buildResultTab(),
                  if (_selectedTab == 1) _buildMeritListTab(),
                  if (_selectedTab == 2) _buildDetailsTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //                        হেডার
  // ============================================================
  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF072B3E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: const Color(0xFF072B3E),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '১৯তম বিজেএস লিখিত পরীক্ষার প্রস্তুতি',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  //                        ট্যাব চিপ
  // ============================================================
  Widget _buildTabChip(String label, int index) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF072B3E) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // ============================================================
  //                    ১. Result ট্যাব
  // ============================================================
  Widget _buildResultTab() {
    final List<Map<String, dynamic>> results = [
      {
        'date': '23/08/2026',
        'title': '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
        'subject': 'Preliminary',
        'score': '-0.25 / 100',
        'rank': '#11 / 12',
      },
      {
        'date': '23/08/2026',
        'title': '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
        'subject': 'Preliminary',
        'score': '-0.25 / 100',
        'rank': '#11 / 12',
      },
    ];

    return Column(
      children: [
        ...results.map((r) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildResultCard(
            date: r['date'],
            title: r['title'],
            subject: r['subject'],
            score: r['score'],
            rank: r['rank'],
          ),
        )),
      ],
    );
  }

  // ============================================================
  //                  ২. Merit List ট্যাব
  // ============================================================
  Widget _buildMeritListTab() {
    final List<Map<String, dynamic>> meritList = [
      {
        'image': 'https://i.pravatar.cc/150?img=12',
        'name': 'AL AMIN SHADHEEN',
        'dept': 'পদার্থ বিদ্যা',
        'score': '৮৪.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=33',
        'name': 'Md. Imran Hossen',
        'dept': 'হিসাব বিজ্ঞান',
        'score': '৮০.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=45',
        'name': 'TaNha',
        'dept': 'রসায়ন',
        'score': '৭৬.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=15',
        'name': 'Ansari',
        'dept': 'ব্যবস্থাপনা',
        'score': '৭৫.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=22',
        'name': 'Satu',
        'dept': 'পদার্থ বিদ্যা',
        'score': '৭০.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=58',
        'name': 'Sayzid Ahmed',
        'dept': 'গণিত',
        'score': '৬৪.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=60',
        'name': 'MD. RAKIBUL HASAN',
        'dept': 'হিসাব বিজ্ঞান',
        'score': '৫৬.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=47',
        'name': 'Ritashree Devi',
        'dept': 'ইংরেজি',
        'score': '৪৬.৫',
      },
      {
        'image': 'https://i.pravatar.cc/150?img=68',
        'name': 'ddfc',
        'dept': 'সাধারণ',
        'score': '-০.৫',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------- কার্ড ১ ----------------
        _buildResultCard(
          date: '23/08/2026, 12:36:00 AM',
          title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
          subject: '',
          score: '',
          rank: '',
          showMeritButton: true,
        ),
        SizedBox(height: 16.h),

        // ---------------- কার্ড ২ (Merit List) ----------------
        _buildResultCard(
          date: '23/08/2026, 12:36:00 AM',
          title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
          subject: '',
          score: '',
          rank: '',
          showMeritButton: true,
        ),
        SizedBox(height: 16.h),

        // ---------------- সার্চ বার ----------------
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'নাম দিয়ে খুঁজুন...',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // ---------------- মেরিট লিস্ট ----------------
        ...meritList.map((student) => _buildMeritListItem(student)),
      ],
    );
  }

  // ============================================================
  //                  ৩. Details ট্যাব
  // ============================================================
  Widget _buildDetailsTab() {
    final List<Map<String, dynamic>> details = [
      {
        'subject': 'বাংলা',
        'correct': '0',
        'wrong': '1',
        'skipped': '19',
        'score': '-0.25',
        'accuracy': '0%',
        'color': const Color(0xFFE53935),
      },
      {
        'subject': 'English',
        'correct': '2',
        'wrong': '4',
        'skipped': '14',
        'score': '1.00',
        'accuracy': '33%',
        'color': const Color(0xFF43A047),
      },
      {
        'subject': 'গণিত',
        'correct': '0',
        'wrong': '1',
        'skipped': '9',
        'score': '-0.25',
        'accuracy': '0%',
        'color': const Color(0xFFE53935),
      },
      {
        'subject': 'বিজ্ঞান',
        'correct': '0',
        'wrong': '0',
        'skipped': '10',
        'score': '0.00',
        'accuracy': '0%',
        'color': const Color(0xFF1A1A1A),
      },
      {
        'subject': 'সাধারণ জ্ঞান',
        'correct': '0',
        'wrong': '1',
        'skipped': '4',
        'score': '-0.25',
        'accuracy': '0%',
        'color': const Color(0xFFE53935),
      },
      {
        'subject': 'কম্পিউটার',
        'correct': '0',
        'wrong': '0',
        'skipped': '5',
        'score': '0.00',
        'accuracy': '0%',
        'color': const Color(0xFF1A1A1A),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------- কার্ড ১ ----------------
        _buildResultCard(
          date: '23/08/2026, 12:36:00 AM',
          title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
          subject: '',
          score: '',
          rank: '',
          showDetails: true,
        ),
        SizedBox(height: 16.h),

        // ---------------- কার্ড ২ ----------------
        _buildResultCard(
          date: '23/08/2026, 12:36:00 AM',
          title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
          subject: 'Preliminary • 22/07/2026',
          score: '',
          rank: '',
          showDetails: true,
          isExpanded: true,
        ),
        SizedBox(height: 16.h),

        // ---------------- সাবজেক্ট ব্রেকডাউন কার্ড ----------------
        ...details.map((d) => _buildSubjectDetailCard(d)),
      ],
    );
  }

  // ============================================================
  //                  রেজাল্ট কার্ড (মূল)
  // ============================================================
  Widget _buildResultCard({
    required String date,
    required String title,
    required String subject,
    required String score,
    required String rank,
    bool showMeritButton = false,
    bool showDetails = false,
    bool isExpanded = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- টপ রো ----------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // আর্কাইভ ব্যাজ
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Archive',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Written',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '08',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // ডান দিকের কন্টেন্ট
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      subject.isEmpty ? date : '$subject • $date',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                Icon(Icons.keyboard_arrow_up,
                    color: Colors.grey.shade600, size: 20.sp),
            ],
          ),

          // ---------------- Merit List বাটন ----------------
          if (showMeritButton) ...[
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.emoji_events,
                    color: Colors.white, size: 16.sp),
                label: Text(
                  'Merit List',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF072B3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],

          // ---------------- স্কোর ও র্যাংক (Result ট্যাবে) ----------------
          if (!showMeritButton && !showDetails) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade200),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'স্কোর',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      score,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE53935),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'মেধাস্থান',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      rank,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF5B301),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  //                  মেরিট লিস্ট আইটেম
  // ============================================================
  Widget _buildMeritListItem(Map<String, dynamic> student) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // প্রোফাইল ছবি
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(student['image']),
          ),
          SizedBox(width: 12.w),
          // নাম ও ডিপার্টমেন্ট
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name'],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  student['dept'],
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // স্কোর
          Text(
            student['score'],
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF072B3E),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //                সাবজেক্ট ডিটেইল কার্ড (Details ট্যাব)
  // ============================================================
  Widget _buildSubjectDetailCard(Map<String, dynamic> detail) {
    final Color scoreColor = detail['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- টপ রো: সাবজেক্ট ও স্কোর ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                detail['subject'],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Row(
                children: [
                  Text(
                    detail['score'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_forward_ios,
                      size: 12.sp, color: Colors.grey.shade500),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // ---------------- প্রোগ্রেস বার ----------------
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: double.parse(
                  (detail['accuracy'] as String).replaceAll('%', '')) /
                  100,
              minHeight: 6.h,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                double.parse((detail['score'] as String).replaceAll('-', '')) >
                    0
                    ? const Color(0xFF43A047)
                    : const Color(0xFFE53935),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // ---------------- কাউন্ট রো ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCountItem('সঠিক', detail['correct'],
                  const Color(0xFF43A047)),
              _buildCountItem('ভুল', detail['wrong'], const Color(0xFFE53935)),
              _buildCountItem(
                  'বাদ', detail['skipped'], const Color(0xFF1A1A1A)),
            ],
          ),
          SizedBox(height: 8.h),
          // অ্যাকুরেসি
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              detail['accuracy'],
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
