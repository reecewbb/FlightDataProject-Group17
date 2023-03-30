class Filter {
  int previousFilter;
  int currentFilter;
  int widgetFilterPressed;
  String[] splitCurrentName;
  String currentName;

  void addAirports(ArrayList<Airport> myAirports) {
    myAirports.add(new Airport(1410, 335, "JFK", ON_BOTTOM));
    myAirports.add(new Airport(130, 580, "LAX", ON_TOP));
    myAirports.add(new Airport(1330, 420, "DCA", ON_TOP));
    myAirports.add(new Airport(150, 50, "SEA", ON_BOTTOM));
    myAirports.add(new Airport(1320, 900, "FLL", ON_BOTTOM));
    myAirports.add(new Airport(450, 890, "HNL", ON_TOP, HAWAII_REGION));
    myAirports.add(new Airport(1015, 340, "ORD", ON_TOP));
    myAirports.add(new Airport(240, 540, "LAS", ON_TOP));
    myAirports.add(new Airport(990, 260, "ATW", ON_TOP));
    myAirports.add(new Airport(780, 700, "DAL", ON_SIDE));
    myAirports.add(new Airport(830, 450, "MCI", ON_TOP));
    myAirports.add(new Airport(820, 810, "HOU", ON_TOP));
    myAirports.add(new Airport(1260, 890, "RSW", ON_TOP));
    myAirports.add(new Airport(145, 600, "LGB", ON_SIDE));
    myAirports.add(new Airport(60, 390, "SMF", ON_TOP));
    myAirports.add(new Airport(600, 650, "LBB", ON_TOP));
    myAirports.add(new Airport(760, 710, "DFW", ON_TOP));
    myAirports.add(new Airport(500, 910, "OGG", ON_TOP, HAWAII_REGION));
    myAirports.add(new Airport(1395, 340, "EWR", ON_TOP));
    myAirports.add(new Airport(380, 260, "IDA", ON_TOP));
    myAirports.add(new Airport(304, 631, "PHX", ON_TOP));
    myAirports.add(new Airport(1276, 839, "MCO", ON_TOP));
    myAirports.add(new Airport(125, 134, "PDX", ON_TOP));
    myAirports.add(new Airport(503, 715, "ELP", ON_TOP));
    myAirports.add(new Airport(56, 427, "SJC", ON_SIDE));
    myAirports.add(new Airport(1470, 253, "BOS", ON_TOP));
    myAirports.add(new Airport(1251, 763, "JAX", ON_TOP));
    myAirports.add(new Airport(754, 896, "CRP", ON_TOP));
    myAirports.add(new Airport(983, 598, "MEM", ON_TOP));
    myAirports.add(new Airport(173, 940, "ADQ", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(190, 886, "ANC", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(47, 422, "SFO", ON_TOP));
    myAirports.add(new Airport(1428, 325, "LGA", ON_TOP));
    myAirports.add(new Airport(156, 620, "SNA", ON_SIDE));
    myAirports.add(new Airport(159, 22, "BLI", ON_SIDE));
    myAirports.add(new Airport(1020, 355, "MDW", ON_SIDE));
    myAirports.add(new Airport(156, 635, "SAN", ON_BOTTOM));
    myAirports.add(new Airport(1185, 356, "CLE", ON_TOP));
    myAirports.add(new Airport(956, 480, "STL", ON_TOP));
    myAirports.add(new Airport(1260, 287, "BUF", ON_TOP));
    myAirports.add(new Airport(1242, 854, "TPA", ON_TOP));
    myAirports.add(new Airport(544, 438, "DEN", ON_TOP));
    myAirports.add(new Airport(1259, 694, "SAV", ON_TOP));
    myAirports.add(new Airport(1071, 571, "BNA", ON_TOP));
    myAirports.add(new Airport(100, 168, "EUG", ON_TOP));
    myAirports.add(new Airport(873, 258, "MSP", ON_TOP));
    myAirports.add(new Airport(1159, 415, "CMH", ON_TOP));
    myAirports.add(new Airport(131, 457, "FAT", ON_TOP));
    myAirports.add(new Airport(717, 829, "SAT", ON_TOP));
    myAirports.add(new Airport(805, 577, "TUL", ON_TOP));
    myAirports.add(new Airport(1327, 922, "MIA", ON_BOTTOM));
    myAirports.add(new Airport(1239, 378, "PIT", ON_TOP));
    myAirports.add(new Airport(186, 604, "PSP", ON_SIDE));
    myAirports.add(new Airport(57, 413, "OAK", ON_TOP));
    myAirports.add(new Airport(1377, 378, "PHL", ON_TOP));
    myAirports.add(new Airport(1071, 424, "IND", ON_TOP));
    myAirports.add(new Airport(615, 730, "MAF", ON_TOP));
    myAirports.add(new Airport(1343, 415, "BWI", ON_SIDE));
    myAirports.add(new Airport(1096, 482, "SDF", ON_TOP));
    myAirports.add(new Airport(1430, 287, "BDL", ON_TOP));
    myAirports.add(new Airport(270, 81, "GEG", ON_TOP));
    myAirports.add(new Airport(439, 444, "GJT", ON_TOP));
    myAirports.add(new Airport(1081, 656, "BHM", ON_TOP));
    myAirports.add(new Airport(1148, 643, "ATL", ON_TOP));
    myAirports.add(new Airport(1217, 603, "GSP", ON_TOP));
    myAirports.add(new Airport(1371, 494, "ORF", ON_TOP));
    myAirports.add(new Airport(757, 606, "OKC", ON_TOP));
    myAirports.add(new Airport(413, 110, "GTF", ON_TOP));
    myAirports.add(new Airport(148, 584, "ONT", ON_SIDE));
    myAirports.add(new Airport(736, 954, "MFE", ON_TOP));
    myAirports.add(new Airport(1140, 332, "DTW", ON_TOP));
    myAirports.add(new Airport(1590, 970, "SJU", ON_TOP)); //Puerto Rico not on Map
    myAirports.add(new Airport(74, 138, "MFR", ON_TOP));
    myAirports.add(new Airport(745, 779, "AUS", ON_TOP));
    myAirports.add(new Airport(659, 113, "MOT", ON_TOP));
    myAirports.add(new Airport(112, 875, "BET", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(473, 575, "ABQ", ON_TOP));
    myAirports.add(new Airport(976, 715, "JAN", ON_TOP));
    myAirports.add(new Airport(485, 394, "HDN", ON_TOP));
    myAirports.add(new Airport(974, 400, "PIA", ON_TOP));
    myAirports.add(new Airport(564, 466, "COS", ON_TOP));
    myAirports.add(new Airport(952, 797, "MSY", ON_TOP));
    myAirports.add(new Airport(623, 267, "RAP", ON_TOP));
    myAirports.add(new Airport(1240, 872, "SRQ", ON_BOTTOM));
    myAirports.add(new Airport(986, 346, "RFD", ON_TOP));
    myAirports.add(new Airport(192, 729, "BRW", ON_BOTTOM, ALASKA_REGION));
    myAirports.add(new Airport(1123, 456, "CVG", ON_BOTTOM));
    myAirports.add(new Airport(81, 419, "SCK", ON_TOP));
    myAirports.add(new Airport(1251, 579, "CLT", ON_TOP));
    myAirports.add(new Airport(870, 541, "SGF", ON_TOP));
    myAirports.add(new Airport(233, 754, "SCC", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(1325, 887, "PBI", ON_SIDE));
    myAirports.add(new Airport(141, 379, "RNO", ON_TOP));
    myAirports.add(new Airport(1464, 287, "PVD", ON_TOP));
    myAirports.add(new Airport(1314, 627, "MYR", ON_TOP));
    myAirports.add(new Airport(1060, 360, "SBN", ON_BOTTOM));
    myAirports.add(new Airport(1296, 661, "CHS", ON_TOP));
    myAirports.add(new Airport(1014, 312, "MKE", ON_TOP));
    myAirports.add(new Airport(78, 532, "SMX", ON_TOP));
    myAirports.add(new Airport(528, 952, "KOA", ON_TOP, HAWAII_REGION));
    myAirports.add(new Airport(1291, 276, "ROC", ON_TOP));
    myAirports.add(new Airport(327, 943, "JNU", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(362, 978, "KTN", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(237, 906, "CDV", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(273, 917, "YAK", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(871, 712, "SHV", ON_TOP));
    myAirports.add(new Airport(853, 576, "XNA", ON_TOP));
    myAirports.add(new Airport(1344, 612, "SIT", ON_TOP));
    myAirports.add(new Airport(268, 236, "BOI", ON_TOP));
    myAirports.add(new Airport(406, 868, "LIH", ON_TOP, HAWAII_REGION));
    myAirports.add(new Airport(337, 953, "PSG", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(336, 961, "WRG", ON_TOP, ALASKA_REGION)); // ON TOP OF ANOTHER
    myAirports.add(new Airport(350, 121, "MSO", ON_TOP));
    myAirports.add(new Airport(361, 377, "SLC", ON_TOP));
    myAirports.add(new Airport(220, 823, "FAI", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(469, 199, "BIL", ON_TOP));
    myAirports.add(new Airport(673, 167, "BIS", ON_TOP));
    myAirports.add(new Airport(327, 643, "AZA", ON_SIDE));
    myAirports.add(new Airport(1313, 542, "RDU", ON_TOP));
    myAirports.add(new Airport(1388, 264, "ALB", ON_TOP));
    myAirports.add(new Airport(975, 480, "BLV", ON_SIDE));
    myAirports.add(new Airport(1408, 319, "HPN", ON_TOP));
    myAirports.add(new Airport(408, 189, "BZN", ON_TOP));
    myAirports.add(new Airport(827, 818, "IAH", ON_BOTTOM));
    myAirports.add(new Airport(557, 950, "ITO", ON_TOP, HAWAII_REGION));
    myAirports.add(new Airport(137, 583, "BUR", ON_BOTTOM));
    myAirports.add(new Airport(1090, 780, "VPS", ON_TOP));
    myAirports.add(new Airport(1332, 476, "RIC", ON_TOP));
    myAirports.add(new Airport(781, 173, "FAR", ON_TOP));
    myAirports.add(new Airport(919, 355, "CID", ON_TOP));
    myAirports.add(new Airport(1369, 390, "ILG", ON_TOP));
    myAirports.add(new Airport(65, 195, "OTH", ON_TOP));
    myAirports.add(new Airport(810, 474, "ATY", ON_TOP));
    myAirports.add(new Airport(1314, 402, "HGR", ON_TOP));
    myAirports.add(new Airport(1255, 277, "IAG", ON_TOP));
    myAirports.add(new Airport(142, 920, "AKN", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(128, 911, "DLG", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(114, 811, "OME", ON_TOP, ALASKA_REGION));
    myAirports.add(new Airport(1026, 712, "MEI", ON_TOP));
    myAirports.add(new Airport(697, 270, "PIR", ON_TOP));
    myAirports.add(new Airport(406, 458, "CNY", ON_TOP));
    myAirports.add(new Airport(1333, 213, "OGS", ON_TOP));
    myAirports.add(new Airport(1008, 749, "PIB", ON_TOP));
    myAirports.add(new Airport(522, 240, "SHR", ON_TOP));
    myAirports.add(new Airport(768, 849, "VCT", ON_TOP));
    myAirports.add(new Airport(552, 375, "LAR", ON_TOP));
    myAirports.add(new Airport(652, 543, "LBL", ON_TOP));
    myAirports.add(new Airport(1266, 388, "JST", ON_TOP));
    myAirports.add(new Airport(868, 317, "MCW", ON_TOP));
    myAirports.add(new Airport(423, 396, "VEL", ON_TOP));
    myAirports.add(new Airport(848, 351, "FOD", ON_TOP));
    myAirports.add(new Airport(999, 439, "DEC", ON_TOP));
    myAirports.add(new Airport(1285, 462, "SHD", ON_TOP));
    myAirports.add(new Airport(1066, 315, "MKG", ON_TOP));
    myAirports.add(new Airport(718, 409, "EAR", ON_TOP));
    myAirports.add(new Airport(914, 257, "EAU", ON_TOP));
    myAirports.add(new Airport(850, 545, "JLN", ON_TOP));
    myAirports.add(new Airport(741, 191, "JMS", ON_TOP));
    myAirports.add(new Airport(738, 127, "DVL", ON_TOP));
    myAirports.add(new Airport(987, 171, "CMX", ON_TOP));
    myAirports.add(new Airport(697, 476, "HYS", ON_TOP));
    myAirports.add(new Airport(943, 463, "CGI", ON_TOP));
    myAirports.add(new Airport(437, 352, "RKS", ON_TOP));
    myAirports.add(new Airport(502, 523, "ALS", ON_TOP));
    myAirports.add(new Airport(542, 384, "CYS", ON_TOP));
    myAirports.add(new Airport(597, 356, "BFF", ON_TOP));
    myAirports.add(new Airport(307, 600, "PRC", ON_TOP));
    myAirports.add(new Airport(669, 395, "LBF", ON_TOP));
    myAirports.add(new Airport(543, 259, "GCC", ON_TOP));
    myAirports.add(new Airport(787, 351, "SUX", ON_TOP));
    myAirports.add(new Airport(913, 508, "TBN", ON_TOP));
    myAirports.add(new Airport(1242, 484, "LWB", ON_TOP));
    myAirports.add(new Airport(1235, 425, "CKB", ON_TOP));
    myAirports.add(new Airport(556, 486, "PUB", ON_TOP));
    myAirports.add(new Airport(464, 301, "RIW", ON_TOP));
    myAirports.add(new Airport(338, 610, "PAN", ON_TOP));
    myAirports.add(new Airport(667, 515, "DDC", ON_TOP));
    myAirports.add(new Airport(772, 489, "SLN", ON_TOP));
    myAirports.add(new Airport(576, 697, "HOB", ON_TOP));
    myAirports.add(new Airport(461, 247, "COD", ON_TOP));
    myAirports.add(new Airport(171, 481, "BIH", ON_TOP));
    myAirports.add(new Airport(1502, 94, "PQI", ON_TOP));
    myAirports.add(new Airport(616, 177, "DIK", ON_TOP));
    myAirports.add(new Airport(958, 909, "SPN", ON_TOP));
    myAirports.add(new Airport(968, 909, "GUM", ON_TOP));
    myAirports.add(new Airport(1255, 397, "LBE", ON_TOP));
    myAirports.add(new Airport(1396, 393, "ACY", ON_TOP));
    myAirports.add(new Airport(978, 909, "USA", ON_TOP));
    myAirports.add(new Airport(1462, 236, "PSM", ON_TOP));
    myAirports.add(new Airport(1173, 420, "LCK", ON_TOP));
    myAirports.add(new Airport(891, 188, "DLH", ON_TOP));
    myAirports.add(new Airport(1302, 307, "ELM", ON_TOP));
    myAirports.add(new Airport(770, 138, "GFK", ON_TOP));
    myAirports.add(new Airport(271, 142, "LWS", ON_TOP));
    myAirports.add(new Airport(1025, 219, "ESC", ON_TOP));
    myAirports.add(new Airport(306, 297, "TWF", ON_TOP));
    myAirports.add(new Airport(1007, 209, "IMT", ON_TOP));
    myAirports.add(new Airport(252, 340, "EKO", ON_TOP));
    myAirports.add(new Airport(736, 236, "ABR", ON_TOP));
    myAirports.add(new Airport(1091, 215, "PLN", ON_TOP));
    myAirports.add(new Airport(773, 402, "LNK", ON_TOP));
    myAirports.add(new Airport(1120, 227, "APN", ON_TOP));
    myAirports.add(new Airport(1092, 187, "CIU", ON_TOP));
    myAirports.add(new Airport(877, 162, "HIB", ON_TOP));
    myAirports.add(new Airport(610, 115, "XWA", ON_TOP));
    myAirports.add(new Airport(865, 199, "BRD", ON_TOP));
    myAirports.add(new Airport(837, 142, "BJI", ON_TOP));
    myAirports.add(new Airport(970, 221, "RHI", ON_TOP));
    myAirports.add(new Airport(532, 308, "CPR", ON_TOP));
    myAirports.add(new Airport(374, 177, "BTM", ON_TOP));
    myAirports.add(new Airport(867, 124, "INL", ON_TOP));
    myAirports.add(new Airport(307, 483, "CDC", ON_TOP));
    myAirports.add(new Airport(365, 278, "PIH", ON_TOP));
    myAirports.add(new Airport(1198, 754, "VLD", ON_TOP));
    myAirports.add(new Airport(1254, 730, "BQK", ON_TOP));
    myAirports.add(new Airport(1023, 661, "GTR", ON_TOP));
    myAirports.add(new Airport(1171, 729, "ABY", ON_TOP));
    myAirports.add(new Airport(1103, 288, "MBS", ON_TOP));
    myAirports.add(new Airport(1131, 744, "DHN", ON_TOP));
    myAirports.add(new Airport(1347, 298, "BGM", ON_TOP));
    myAirports.add(new Airport(1390, 309, "SWF", ON_TOP));
    myAirports.add(new Airport(1380, 362, "TTN", ON_TOP));
    myAirports.add(new Airport(1234, 822, "PIE", ON_TOP));
    myAirports.add(new Airport(1251, 859, "PGD", ON_TOP));
    myAirports.add(new Airport(1278, 809, "SFB", ON_TOP));
    myAirports.add(new Airport(375, 378, "PVU", ON_TOP));
    myAirports.add(new Airport(849, 232, "STC", ON_TOP));
    myAirports.add(new Airport(1560, 875, "BQN", ON_TOP));
    myAirports.add(new Airport(1499, 970, "PSE", ON_TOP));
    myAirports.add(new Airport(313, 952, "SIT", ON_TOP));
    myAirports.add(new Airport(366, 99, "FCA", ON_TOP));
    myAirports.add(new Airport(196, 85, "EAT", ON_TOP));
    myAirports.add(new Airport(136, 62, "PAE", ON_TOP));
    myAirports.add(new Airport(220, 132, "PSC", ON_TOP));
    myAirports.add(new Airport(323, 273, "SUN", ON_TOP));
    myAirports.add(new Airport(266, 120, "PUW", ON_TOP));
    myAirports.add(new Airport(480, 705, "ALW", ON_TOP));
    myAirports.add(new Airport(391, 164, "HLN", ON_TOP));
    myAirports.add(new Airport(86, 311, "RDD", ON_TOP));
    myAirports.add(new Airport(196, 111, "YKM", ON_TOP));
    myAirports.add(new Airport(37, 968, "ADK", ON_TOP));
    myAirports.add(new Airport(141, 779, "OTZ", ON_TOP));
    myAirports.add(new Airport(1450, 267, "ORH", ON_TOP));
    myAirports.add(new Airport(1329, 290, "ITH", ON_TOP));
    myAirports.add(new Airport(1188, 474, "HTS", ON_TOP));
    myAirports.add(new Airport(1288, 355, "SCE", ON_TOP));
    myAirports.add(new Airport(1426, 335, "ISP", ON_BOTTOM));
    myAirports.add(new Airport(1285, 613, "FLO", ON_TOP));
    myAirports.add(new Airport(1327, 241, "ART", ON_TOP));
    myAirports.add(new Airport(1271, 491, "LYH", ON_TOP));
    myAirports.add(new Airport(1384, 439, "SBY", ON_TOP));
    myAirports.add(new Airport(1361, 547, "PGV", ON_TOP));
    myAirports.add(new Airport(1357, 494, "PHF", ON_BOTTOM));
    myAirports.add(new Airport(633, 619, "AMA", ON_TOP));
    myAirports.add(new Airport(81, 249, "MFR", ON_TOP));
    myAirports.add(new Airport(43, 392, "STS", ON_SIDE));
    myAirports.add(new Airport(1213, 643, "AGS", ON_TOP));
    myAirports.add(new Airport(1121, 782, "ECP", ON_TOP));
    myAirports.add(new Airport(1138, 702, "CSG", ON_TOP));
    myAirports.add(new Airport(1200, 467, "CRW", ON_TOP));
    myAirports.add(new Airport(1357, 577, "OAJ", ON_TOP));
    myAirports.add(new Airport(1297, 825, "MLB", ON_TOP));
    myAirports.add(new Airport(1505, 157, "BGR", ON_TOP));
    myAirports.add(new Airport(1365, 575, "EWN", ON_TOP));
    myAirports.add(new Airport(1304, 578, "FAY", ON_TOP));
    myAirports.add(new Airport(1176, 361, "CAK", ON_BOTTOM));
    myAirports.add(new Airport(1229, 323, "ERI", ON_TOP));
    myAirports.add(new Airport(1269, 786, "DAB", ON_TOP));
    myAirports.add(new Airport(1271, 686, "HHH", ON_SIDE));
    myAirports.add(new Airport(1249, 504, "ROA", ON_TOP));
    myAirports.add(new Airport(696, 407, "CHO", ON_TOP));
    myAirports.add(new Airport(1394, 195, "BTV", ON_TOP));
    myAirports.add(new Airport(1321, 414, "FNT", ON_TOP));
    myAirports.add(new Airport(929, 796, "LFT", ON_TOP));
    myAirports.add(new Airport(1205, 582, "AVL", ON_TOP));
    myAirports.add(new Airport(862, 814, "BPT", ON_TOP));
    myAirports.add(new Airport(1103, 320, "LAN", ON_TOP));
    myAirports.add(new Airport(1365, 347, "ABE", ON_TOP));
    myAirports.add(new Airport(783, 795, "CLL", ON_TOP));
    myAirports.add(new Airport(902, 292, "RST", ON_TOP));
    myAirports.add(new Airport(737, 401, "GRI", ON_TOP));
    myAirports.add(new Airport(47, 431, "MRY", ON_BOTTOM));
    myAirports.add(new Airport(955, 417, "SPI", ON_TOP));
    myAirports.add(new Airport(1047, 722, "MOB", ON_TOP));
    myAirports.add(new Airport(1093, 716, "MGM", ON_TOP));
    myAirports.add(new Airport(1163, 771, "TLH", ON_TOP));
    myAirports.add(new Airport(924, 713, "MLU", ON_TOP));
    myAirports.add(new Airport(859, 671, "TXK", ON_TOP));
    myAirports.add(new Airport(1023, 414, "CMI", ON_TOP));
    myAirports.add(new Airport(731, 668, "SPS", ON_TOP));
    myAirports.add(new Airport(1014, 186, "MQT", ON_TOP));
    myAirports.add(new Airport(772, 760, "ACT", ON_TOP));
    myAirports.add(new Airport(949, 383, "MLI", ON_TOP));
    myAirports.add(new Airport(937, 343, "DBQ", ON_TOP));
    myAirports.add(new Airport(685, 513, "GCK", ON_BOTTOM));
    myAirports.add(new Airport(1125, 615, "CHA", ON_TOP));
    myAirports.add(new Airport(909, 761, "AEX", ON_TOP));
    myAirports.add(new Airport(891, 802, "LCH", ON_TOP));
    myAirports.add(new Airport(1140, 339, "DRT", ON_SIDE));
    myAirports.add(new Airport(729, 642, "LAW", ON_TOP));
    myAirports.add(new Airport(908, 286, "LSE", ON_SIDE));
    myAirports.add(new Airport(897, 349, "ALO", ON_TOP));
    myAirports.add(new Airport(1081, 333, "AZO", ON_TOP));
    myAirports.add(new Airport(669, 732, "ABI", ON_TOP));
    myAirports.add(new Airport(760, 583, "SWO", ON_TOP));
    myAirports.add(new Airport(974, 436, "PIA", ON_BOTTOM));
    myAirports.add(new Airport(1018, 779, "GPT", ON_TOP));
    myAirports.add(new Airport(674, 877, "LRD", ON_TOP));
    myAirports.add(new Airport(844, 727, "GGG", ON_TOP));
    myAirports.add(new Airport(958, 252, "CWA", ON_TOP));
    myAirports.add(new Airport(1000, 415, "BMI", ON_TOP));
    myAirports.add(new Airport(745, 954, "BRO", ON_BOTTOM));
    myAirports.add(new Airport(1139, 361, "TOL", ON_TOP));
    myAirports.add(new Airport(822, 722, "TYR", ON_TOP));
    myAirports.add(new Airport(1052, 494, "EVV", ON_TOP));
    myAirports.add(new Airport(1243, 623, "CAE", ON_TOP));
    myAirports.add(new Airport(789, 473, "MHK", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
    myAirports.add(new Airport(, , "", ON_TOP));
  }
  /*void whichWidget()
   {
   if(mapScreen.widgetList.get(2).event)
   {
   widgetFilterPressed = 1;
   }
   if(mapScreen.widgetList.get(3).event)
   {
   widgetFilterPressed =2;
   }
   if(mapScreen.widgetList.get(4))
   {
   widgetFilterPressed= 3;
   }
   }*/

  void showAirports(ArrayList<Airport> myAirports)
  {
    //currentFilter = widgetFilterPressed;
    /*if(currentFilter!=previousFilter)
     {
     for(int i=0; i<myAirports.size();i++)
     {
     if(myAirports.get(i).x>2000)
     {
     myAirports.get(i).x = myAirports.get(i).x - 2000;
     }
     }
     }*/


    for (int i=0; i<myAirports.size(); i++)
    {
      currentName = myAirports.get(i).name;
      splitCurrentName = currentName.split("");
      if (currentFilter==1)
      {
        if (splitCurrentName[0].equals("A")||splitCurrentName[0].equals("B")||splitCurrentName[0].equals("C")||
          splitCurrentName[0].equals("D")||splitCurrentName[0].equals("E")||splitCurrentName[0].equals("F")||splitCurrentName[0].equals("G")||
          splitCurrentName[0].equals("H")||splitCurrentName[0].equals("I")||splitCurrentName[0].equals("J")||splitCurrentName[0].equals("K"))
        {
          if (myAirports.get(i).x>2000)
          {
            while (myAirports.get(i).x>2000)
            {
              myAirports.get(i).x = myAirports.get(i).x-2000;
            }
          }
          myAirports.get(i).x = myAirports.get(i).x;
        } else
        {
          myAirports.get(i).x = myAirports.get(i).x + 2000;
        }
      }

      if (currentFilter == 2)
      {
        if (splitCurrentName[0].equals("L")||splitCurrentName[0].equals("M")||splitCurrentName[0].equals("N")||
          splitCurrentName[0].equals("O")||splitCurrentName[0].equals("P")||splitCurrentName[0].equals("Q")||splitCurrentName[0].equals("R")||
          splitCurrentName[0].equals("S"))
        {
          if (myAirports.get(i).x>2000)
          {
            while (myAirports.get(i).x>2000)
            {
              myAirports.get(i).x = myAirports.get(i).x-2000;
            }
          }
          myAirports.get(i).x = myAirports.get(i).x;
        } else
        {
          myAirports.get(i).x = myAirports.get(i).x + 2000;
        }
      }

      if (currentFilter==3)
      {
        if (splitCurrentName[0].equals("T")||splitCurrentName[0].equals("U")||splitCurrentName[0].equals("V")
          ||splitCurrentName[0].equals("W")||splitCurrentName[0].equals("X")||splitCurrentName[0].equals("Y")||splitCurrentName[0].equals("Z"))
        {
          if (myAirports.get(i).x>2000)
          {
            while (myAirports.get(i).x>2000)
            {
              myAirports.get(i).x = myAirports.get(i).x-2000;
            }
          }
          myAirports.get(i).x = myAirports.get(i).x;
        } else
        {
          myAirports.get(i).x = myAirports.get(i).x + 2000;
        }
      }

      if (currentFilter==4)
      {
        if (myAirports.get(i).x>2000)
        {
          while (myAirports.get(i).x>2000)
          {
            myAirports.get(i).x = myAirports.get(i).x-2000;
          }
        }
      }
    }
    previousFilter = currentFilter;
  }
}
