List<Product> Products = [
  Product(
    price: '59',
    category: "سماعات لاسلكية",
    name: "جودة صوت عالية",
    image: "images/airpod.png",
    description:
        "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
  ),
  Product(
    price: '1099',
    category: "جهاز موبايل",
    name: "وأصبح للموبايل قوة",
    image: "images/mobile.png",
    description:
        "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
  ),

  Product(
    price: '56',
    category: "سماعات",
    name: "لساعات استماع طويلة",
    image: "images/headset.png",
    description:
        "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
  ),
  Product(
    price: '68',
    category: "مسجل صوت",
    name: "سجل اللحظات المهمة حولك",
    image: "images/speaker.png",
    description:
        "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
  ),
  Product(
    price: '39',
    category: "كاميرات كمبيوتر",
    name: "بجودة ودقة صورة عالية",
    image: "images/camera.png",
    description:
        "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
  ),
];

class Product {
  final String category;
  final String name;
  final String price;
  final String image;
  final String description;

  Product({
    required this.category,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      category: data['category'] ?? 'بدون عنوان',
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      image: data['image'] ?? '',
      description: data[''] ?? '', // لو عندك صور
    );
  }
}
