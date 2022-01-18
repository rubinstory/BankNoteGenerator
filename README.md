# 구스

#### 금융 문맹을 위한 자동매매 플랫폼, '구스'

## Period
2021.01.12 ~ 2022.01.18

## Contributors

#### 박현준 [Dookong](https://github.com/Dookong)
#### 이준영 [rubinstory](https://github.com/rubinstory)

<img src = "https://user-images.githubusercontent.com/6710663/149927458-b3fb6489-4b60-4d07-96e2-5e05cd4f0f4b.png">



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
