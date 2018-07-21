## 정형분석파일의 종류
# Database (Oracle, MySQL, MariaDB)
# Exel (xls)
# csv (Comma separated Vector)
# 외부 라이브러리는 타 개발자가
# 만들어 놓은 함수의 집합

install.packages("dplyr")
library(dplyr)
scores <-  data.frame(read.csv("class_scores.csv"))
scores
head(scores) #제일상위6개
tail(scores) #제일하위6개
dim(scores) #로우데이터의 열과행 수
summary(scores) # 요약
View(scores)

# Stu_ID, scores, class, gender
# Math, English, Science, Marketing, Writing
## select : 선택한 meta data(variable)에 해당하는 instance를 출력
## filter, distance, top_n, sample_n : 선택한 row(observation) - key value 에 해당하는 instance 를 출력
## mutate, transmutate, mutate_each : data transform
## group_by : group data
## summarise, summarise_each, count : summary
## arrange : data sorting
## inner_join, left_join, right_join, full_join : combination or join

head(scores)
## mean, max, min
head(select(scores,"Math"))
x<-mean(select(scores,"Math"))

## NA, NULL
## NA : Not Available -> 값이 있긴한데 정확히 몇인지는 모르는상태, 값이 있는것이 포인트
## NULL : 값이 없는 상태, 비어있음, 0과는 다른 개념
filter(Math > 60)



##select 예제
## 1 영어, 수학, 과학 도메인(=컬럼)만 가져오기
scores %>% 
  dplyr::select(Math, English, Science) %>%
  head
#dplyr를 쓰려면 파이프라인%>%을 줘야하
## 2 상위 10개 보기 slice
scores %>%
  dplyr::select(Math, English, Science) %>%
  slice(1:10)
## 3 성별 제외한 컬럼 보기
scores %>%
  dplyr::select(-gender) %>%
  slice(1:12)
## 4 수학부터 작문까지 컬럼 보기
scores %>%
  dplyr::select(Math:Writing) %>%
  slice(1:3)
## 5 모든 컬럼 조회 everything()
scores %>%
  dplyr::select(everything()) %>%
  slice(1:3)
## 6 E 로 시작하는 컬럼만 보기 starts_with('E')
scores %>%
  dplyr::select(starts_with()) %>%
  slice(1:3)
## 7 e 로 끝나는 컬럼만 보기 ends_with('e')
scores %>%
  dplyr::select(ends_with('e')) %>%
  slice(1:3)
## 8 e 가 들어가는 컬럼 다 가져오기 contains('e')
scores %>%
  dplyr::select(contains('e')) %>%
  slice(1:3)
## 9.  1, 3, 5번째 컬럼만 가져오기 
scores %>%
  dplyr::select('1,3,5') %>%
  slice(1:3)



## filter 예제
## 1. 1학년 학생들만 보기
scores %>%
  filter(grade==1)%>%
  slice(1:3)
## 2. 1학년 남학생만 보기
scores %>%
  filter(grade==1 & gender =='M')%>%
  slice(1:3)
## 3. 1학년이 아닌 학생들만 보기
scores %>%
  filter(!grade ==1)%>%
  slice(1:3)
## 4. 1, 2학년 학생들만 보기
scores %>%
  filter(grade ==1 | grade == 2)%>%
  slice(1:3)
## 5. 수학점수가 80이상인 학생들만 보기
scores %>%
  filter(Math >= 80 )%>%
  slice(1:3)
  ## 6. 수학점수가 80 이상이면서 영어점수가
##     70이상이 학생들만 보기
scores %>%
  filter(Math >= 80 | English >= 70 )%>%
  slice(1:3)
## 7. 학번이 10101 부터 10120인 학생들
##    중에서 여학생이면서 영어가 80점 이상인
##    학생만 보기
scores %>%
  filter(Stu_ID >=10101 & Stu_ID <=10120 & gender=='F' & English >=80 )%>%
  slice(1:3)
## 8. 학번이 홀수인 학생들 중 남자이면서 
##    수학과 과학이 모두 90점 이상인
##    학생들만 보기
scores %>%
  filter(Stu_ID /2=0 & gender=='M' & Math >=90 | English >=80 )%>%
  slice(1:3)
## 9. 학생들 중 한 과목이라도 100점이 있는
##    학생만 보기
scores %>%
  filter(  )%>%
  slice(1:3)

## 10. 학생들 중 한 과목이라도 0점이 있는
##     학생만 보기
scores %>%
  filter(  )%>%
  slice(1:3)



##mutate예제 (컬럼을 추가하는 것)
##1.scores에 Average 컬럼(학생평균점수) 추가
scores <-scores %>% dplyr::mutate(Average=(Math+English+Science+Marketing+Writing)/5) 
scores %>% slice(1:3)

##2.학생들 평균점수를 기준으로 Rank(순위) 추가
scores <-scores %>% dplyr::mutate(Rank=dense_rank(desc(Average)))
scores %>% 
  slice(1:3)


### arrange 예제
##3. Average를 기준으로 정렬하기
## arrange(Average) (주의: average()는 함수)
scores %>%
  dplyr::arrange(Rank) %>%
  slice(1:3)

###ifelse예제
## mutate를 통해 eval 생성하기(A ~ F )
##ifelse(Average >=90, 'A' ifelse())
## 4. 평균점수가 90점 이상이면 'A', 80 >= 'B', 70>='C', 60>='D', 50>='E', 나머지'F'

scores <-scores %>% dplyr::mutate(eval='A','B','C','D','E','F')
                                  ifelse(Average>=90, 'A'),
                                  ifelse(Average>=80, 'B'),
                                  ifelse(Average>=70, 'C'),
                                  ifelse(Average>=60, 'D'),
                                  ifelse(Average>=50, 'E'),
                                  else = F)
scores %>% 
  slice(1:3)


#### group_by 예제
## 학생별 학생수 보기
 scores %>%
   dplyr::group_by(grade) %>%
   dplyr::summarise(count = length(grade))

 
##평균점수를 성별로 보기
temp <- scores %>%
mutate(temp_avg = (Math+English+Science+Marketing+Writing)/5) %>%
      group_by(gender) %>%
   summarise(성별평균점수=mean(temp_avg))
 
#히스토그램
hist(temp $성별평균점수,
      xlab="남",
      col="yellow",
      border = "blue")
 
 #바차트
 barplot(temp $성별평균점수)
 
 #파이차트
 pie(
   c(temp$성별평균점수),
   c("남", "여"),
   col=c("blue", "red")
 )
 
#라인차트
plot(c(temp$성별평균점수), type="o")
 
 
 
 



