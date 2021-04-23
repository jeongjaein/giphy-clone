# GIPHY PROJECT

<br>
<br>
<br>
<p float="left">
<img src="https://user-images.githubusercontent.com/54730280/115800890-6bd09680-a416-11eb-96e9-508a1552753e.gif" width="190" /> 
<img src="https://user-images.githubusercontent.com/54730280/115800898-6f641d80-a416-11eb-9ca7-6fd53821c930.gif" width="190" />
<img src="https://user-images.githubusercontent.com/54730280/115800892-6d01c380-a416-11eb-84c7-88b91b33b221.gif" width="190" />
<img src="https://user-images.githubusercontent.com/54730280/115800895-6d9a5a00-a416-11eb-9756-36aabc70157d.gif" width="190" />
</p>


------------

## 기능 설명

### 1. 상단 탭
<br>
- GIPHY 앱 내 있는 상다 탭바 애니메이션으 구현해보았습니다.

- 이동한 거리에 따른 좌우 흔들림 폭 변화, target이 되는 View속 UILabel에 맞는 Size 동적 변화

- 추후 아래 다른 뷰들과의 연계로 확장 가능
-----------
<br>

### 2. 최근 검색어
<br>
- 최근 검색어를 보여주는 좌우 paging CollectionView 입니다.

- GIPHY API 중 ```Random ID``` 를 사용하여 부여받은 ID와 매핑되어있는 검색어들 입니다.

- 중복 검색어 X

- 최신순으로 보여주며 5개 이상일 시 밀어내기

- Dynamic Width 구현
-----------
<br>

### 3. 검색 결과 화면
<br>

- 이미지 Height에 따른 Dynamic Collection View 입니다.

- GIPHY API ```Search``` 리스폰스로 떨어지는 이미지의 사이즈를 사용하여 Cell 높이 계산시 퍼포먼스를 향상시켰습니다.
----------
<br>

### 4. 인기 검색어

<br>

- GIPHY API 중 ```Trending``` 을 통해 인기검색어를 받아와 사용자에게 보여줍니다.

- tap 시 검색결과 화면으로 이동합니다.
----------
<br>

### 5. 검색 제안
<br>

- GIPHY API 중  ```SearchSugession```을 통해 추천검색어를 받아와 사용자에게 보여줍니다.

- tap 시 검색결과 화면으로 이동합니다.
--------
<br>

### 6. 이미지 디테일

<br>

- 이미지를 양옆으로 스와이프가 가능합니다.

- 추후 carousel collection view 로 확장 시켜 사용자 경험 측면에서의 퀄리티를 높힐 수 있다고 생각합니다.
------------
<br>

### 7. 좋아요

- 하트 버튼을 클릭 시 좋아요가 가능합니다.👍
- CoreData에 적재하여 앱을 재시작하더라도 같은 좋아요 데이터를 유지하게끔 되어있습니다ㅏ.

- 이때 좋아요 리스트 또한 최근 검색어와 마찬가지로 GIPHY API 중 ```Random ID```로 부터 받아온 ID와 매핑되어있습니다.

- 로그인, 로그아웃이 가능한 서비스로의 확장성을 고려해 기기에 종속된 좋아요 리스트가아닌 사용자에게 종속된 좋아요리스트로 분리하였습니다.

------------
## 구조

VIPER 


VIPER 구조로 개발하였습니다.

![image](https://user-images.githubusercontent.com/54730280/115802530-0d0d1c00-a41a-11eb-8c30-42b7c94360b3.png)


