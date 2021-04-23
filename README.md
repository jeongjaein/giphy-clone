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

<br>
<br>
<br>


# ✅ 디자인 패턴

### VIPER 패턴이 적용되어있습니다.



![image](https://user-images.githubusercontent.com/54730280/115802530-0d0d1c00-a41a-11eb-8c30-42b7c94360b3.png)


<br>
<br>
<br>

# 📍 요구 사항

## 1️⃣ key word 검색
<br>

### 총 5가지 방법으로 __Key Word__ 검색이 가능합니다.

<br>

✓  검색 버튼 Tap

✓ keyboard Return 버튼 Tap

✓ 인기 검색어 Cell Tap   👉 ```Trending Search Terms API``` 사용

✓ 검색 제안 Cell Tap    👉 ```Search Suggesions API```  사용

✓ 최근 검색어 Cell Tap   👉 ```Core Data``` 사용

<br>

위 동작들은 다음과 같은 시나리오를 진행합니다.

1. __Interactor__ 에서 유효성검사를 거친 뒤 __CoreDataManager__ 에 적재 요청
2. __CoreDataManager__ 는 userID와 매핑된 검색어 리스트가 있는 지 확인
3. 비어있다면 첫번째 검색어를 추가
4. 존재한다면 추가하게될 검색어와 중복된 검색기록이 있는지 확인
5. 중복 검색어가 존재한다면 기존의 것을 삭제 후 추가하게 될 검색어를 0번째 인덱스에 Insert
6. 중복 검색어가 없다면 0번째 인덱스에 Insert, 리스트의 Count가 5개를 초과하는지 확인
7. 위 과정을 통과한 검색어는 Presenter로 돌아와 keyword와 함께 검색 결과 화면으로 이동합니다.

<br>
<br>
<br>

## 2️⃣ 검색된 아이템 목록 화면

- Giphy 앱과 흡사한 세로의 길이가 Dynamic한 CollectionView로 이루어져 있습니다.
- 리스폰스로 떨어지는 Image Size의 가로세로 비율을 통해 Cell의 높이를 계산하여 퍼포먼스를 향상 시켰습니다.

<br>
<br>
<br>

## 3️⃣ 검색된 아이템 상세 화면

- 선택된 Image의 대표이미지는 CollectionView로 양옆으로 Swipe가 가능합니다. 
  - (추후 carousel한 Collection View로 확장시켜 사용성을 높힐 수 있다고 생각합니다.)
- 해당 이미지 업로더의 정보를 확인해볼 수 있습니다.
  - 프로필이미지, DisplayName, userImage, isVerified, likeButton 등등..
- 🧡 버튼을 통한 좋아요 기능이 구현되어 있고 아래와 같은 시나리오를 거치게 됩니다.

<br>
<br>

1. __Interactor__ 는 __CoreDataManager__ 에게 현재 좋아요 상태를 Return 받습니다.
2. 받은 Return값에 따라 적절하게 __like()__ 혹은 __unlike()__ 를 호출하게 됩니다.
- __like()__ 의 동작
   - 좋아요 리스트가 없다면 좋아요 리스트생성과 동시에 gifID를 append
   - 좋아요 리스트가 있다면 좋아요 리스트에 gifID를 append
- __unlike()_의 동작
   - 좋아요 리스트에서 해당 gifID remove
3. 완료 여부를 Interactor에게 Return

<br>
<br>

✅ 로그인, 로그아웃이 가능한 서비스로의 확장을 고려하여 RandomID를 받아 

기기에 종속된 좋아요 리스트가아닌 사용자에게 종속된 좋아요 리스트로 분리하였습니다.
<br>
<br>
<br>

# 👊 추가 구현 기능

## 1. 상단 탭

<br>

- GIPHY 앱 내 있는 상다 탭바 애니메이션을 구현해보았습니다.

- 이동한 거리에 따른 좌우 흔들림 폭 변화, target이 되는 View속 UILabel에 맞는 Size 동적 변화

- 추후 아래 다른 뷰들과의 연계로 확장 가능


<br>
<br>
<br>

## 2. 최근 검색어

<br>

- 최근 검색어를 보여주는 좌우 paging CollectionView 입니다.

- GIPHY API 중 ```Random ID``` 를 사용하여 부여받은 ID와 매핑되어있는 검색어들 입니다.

- 중복 검색어 X

- 최신순으로 보여주며 5개 이상일 시 밀어내기

- Dynamic Width 구현

<br>
<br>
<br>

## 3. 인기 검색어

<br>

- GIPHY API 중 ```Trending Search Terms API``` 을 통해 인기검색어를 받아와 사용자에게 보여줍니다.

- tap 시 검색결과 화면으로 이동합니다.

<br>
<br>
<br>

## 4. 검색 제안
<br>

- GIPHY API 중  ```Search Suggesions API``` 을 통해 추천검색어를 받아와 사용자에게 보여줍니다.

- tap 시 검색결과 화면으로 이동합니다.

<br>
<br>
<br>



추가적인 사항으로

✔︎ AppColor를 통한 앱 내 Color관리

✔︎ NetWorkRouter를 통한 간편한 API 호출

✔︎ Extension을 통해 중복되거나, 깔끔하지 못한 코드들을 해결
등등

많은 고려사항들이 들어 있습니다!

<br>
<br>
<br>


## 읽어주셔서 감사합니다. 🙇🏻


