import '../models/product.dart';

// 실제 앱에서는 이 데이터가 API 서버로부터 받아온 결과물이 됩니다.
const List<Product> sampleProducts = [
  Product(
    id: 1,
    name: '아이폰 15',
    description: '최신 아이폰으로 강력한 성능과 뛰어난 카메라를 제공합니다.',
    price: 1200000,
    imageUrl: 'https://picsum.photos/id/1/200/200',
    category: '전자제품',
  ),
  Product(
    id: 2,
    name: '맥북 프로',
    description: '개발자를 위한 최고의 노트북입니다.',
    price: 2500000,
    imageUrl: 'https://picsum.photos/id/2/200/200',
    category: '전자제품',
  ),
  Product(
    id: 3,
    name: '에어팟 프로',
    description: '노이즈 캔슬링 기능이 있는 무선 이어폰입니다.',
    price: 300000,
    imageUrl: 'https://picsum.photos/id/3/200/200',
    category: '전자제품',
  ),
  Product(
    id: 4,
    name: '나이키 운동화',
    description: '편안하고 스타일리시한 운동화입니다.',
    price: 150000,
    imageUrl: 'https://picsum.photos/id/4/200/200',
    category: '의류',
  ),
  Product(
    id: 5,
    name: '스타벅스 텀블러',
    description: '환경을 생각하는 재사용 텀블러입니다.',
    price: 25000,
    imageUrl: 'https://picsum.photos/id/5/200/200',
    category: '생활용품',
  ),
];
