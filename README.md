#### 2021 KAIST 몰입캠프 겨울학기 3주차 프로젝트
###### 한양대학교 컴퓨터소프트웨어학부 박현준, 부산대학교 정보컴퓨터공학부 이준영
# 금융 문맹을 위한 자동매매 플랫폼, '구스'

## Period
2021.01.12 ~ 2022.01.18

## Contributors

#### 박현준 [Dookong](https://github.com/Dookong)
#### 이준영 [rubinstory](https://github.com/rubinstory)


## 프로젝트 소개

<img src = "https://user-images.githubusercontent.com/6710663/149927458-b3fb6489-4b60-4d07-96e2-5e05cd4f0f4b.png">

![](https://images.velog.io/images/rubinstory/post/88a12673-e6ca-4429-a184-5ab10e9e3ebc/1.png)

## 과제 소개
3주차 과제의 경우 각 조별 자유 프로젝트를 진행하는 것이다. 우리 조의 프로젝트 주제는 아래와 같다.
>
투자에 미숙한 사람들을 위한 맞춤형 암호화폐 자동매매 어플리케이션

이번 프로젝트는 프론트, 백엔드, 투자 알고리즘 등 총 3개의 파트로 나누어 진행헀다.

### 트레이딩 모듈

#### 라이브러리
- [ftx](https://pypi.org/project/ftx/) - FTX 거래소의 데이터 수신 및 주문 전송
- apscheduler - 거래소 데이터의 주기적인 업데이트
- requests - 백엔드 서버로의 데이터 전송
- pandas - 가격 데이터 분석

#### 트레이딩 로직 A
볼린저 밴드와 캔들 패턴의 수렴발산을 이용한 단타 전략. 가격의 이동평균의 표준편차를 계산하여 순간적인 극값을 도출 후 공매수/공매도하여 수익 창출.


<img width="445"  src="https://user-images.githubusercontent.com/6710663/149932849-797315e4-3820-4510-a9b2-d5925ac80549.png">

#### 트레이딩 로직 C
RSI와 MACD 지표를 조합하여 매매하는 중단기 스윙 전략. 과매수 구간에 돌입할 때 진입하여 과매수 구간을 이탈할 때 청산하는 방식으로 수익 창출.


<img width="400" src="https://user-images.githubusercontent.com/6710663/149932314-134600ac-6f61-42f7-9f6b-558f55e489af.png">

## Front - End
### Communication
***
이번 프로젝트에서는 서버와의 통신을 REST API를 기반으로 설계했다. 따라서 클라이언트에서도 REST 방식으로 통신을 해야한다.

클라이언트의 경우 iOS 단말기를 대상으로 진행했으며, Dart와 Flutter를 이용해 프로그래밍했다.

```dart
@RestApi(baseUrl: "http://192.249.18.201:80/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('user/{user_id}')
  Future<UserModel> fetchCurrentUser(@Path('user_id') int userId);

  @GET('asset_manage/{user_id}')
  Future<AssetManageModel> fetchAssetManageItem(@Path('user_id') int userId);

  @POST('asset_manage/')
  Future<AssetManageModel> updateAssetManageModel(
    @Body() AssetManageModel assetManageModel,
  );

  @GET('transaction/')
  Future<List<TransactionModel>> fetchTransactionList(
      @Query('user') int userId);
}
```
REST 통신을 위해 Retrofit 라이브러리를 사용했다.
### Design Pattern
***
이번 프로젝트에서는 사용자 정보 저장을 위한 Django 서버와 거래 관련 정보 조회를 위한 FTX, 총 2군데의 서버와 통신을 해야한다. 따라서 Google에서 권장하는 BLOC 디자인 패턴을 클라이언트에 적용하였다.

![BLOC](https://blog.kakaocdn.net/dn/cVYO9x/btq52qtg7zN/DGHEw21kvMgtTJYjlDCPfK/img.png)
<br>

```dart
class UserModel {
  int _id = 0;
  String _firstName = "";
  String _lastName = "";
  String _username = "";

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _firstName = parsedJson['first_name'];
    _lastName = parsedJson['last_name'];
    _username = parsedJson['username'];
  }

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get fullName => _lastName + _firstName;
  String get username => _username;
}

```

```dart
class UserAPIProvider {
  Future<UserModel> fetchUser(int userId) async {
    final response = RestClient(Dio()).fetchCurrentUser(userId);
    return response;
  }
}
```

```dart
class UserRepository {
  final userAPIProvider = UserAPIProvider();
  Future<UserModel> fetchUser(int userId) => userAPIProvider.fetchUser(userId);
}
```

```dart
class UserBloc {
  final _repository = UserRepository();
  final _userFetcher = PublishSubject<UserModel>();

  Stream<UserModel> get currentUser => _userFetcher.stream;
  fetchCurrentUser() async {
    UserModel userModel = await _repository.fetchUser(CURRENT_USER_ID);
    CURRENT_USER_ID = userModel.id;
    _userFetcher.sink.add(userModel);
  }

  dispose() {
    _userFetcher.close();
  }
}
```


<br>

### Main Screen
***
메인화면에서는 사용자의 자산 현황과 수익률을 조회할 수 있다. 그리고 수익률을 분석하여 시각화한 그래프를 통해 최근 3일간의 투자 현황을 확인할 수 있으며, 배너와 카드뉴스를 통해 추천 받은 정보를 확인할 수 있다.

![](https://images.velog.io/images/rubinstory/post/e58885b1-0ed5-4496-99bb-ada376de2021/2.png)

투자 관련 정보는 모두 FTX 거래소에 요청을 보내 받아오는 정보들이며, 그 이외의 경우 모두 Django 서버로부터 받아오는 정보이다.
<br>

### Trade Information Screen
***

![](https://images.velog.io/images/rubinstory/post/6cc7440d-b308-43ef-a877-1a330d21cd61/3.png)

투자 정보 조회 화면에서는 사용자가 보유하고 있는 자산 현황과 현재 적용 중인 알고리즘의 종류를 확인할 수 있다. 그리고 사용자의 투자 성향에 대해 간단히 설명해주는 섹션이 있으며, 투자 유형 변경과 거래 내역을 조회할 수 있다.


![](https://images.velog.io/images/rubinstory/post/31165c9e-0bf6-4027-97b6-a8f69a201f39/4.png)
