
# 데이터 요약

# 1.2 연속형 변수 요약

# ------------------------------------------------------------------------------

# 데이터
library(MASS)
str(survey)

# 요약 통계량 함수는 데이터에 결측값(NA)이 포함되어 있으면  NA를 반환
# -> na.rm=T 인수를 지정하여 NA제외

# median(): 중위값
median(survey$Pulse,na.rm = T)

# quantile(데이터,probs=0.05): 백분위수(관측값의 5%보다는 크고 95%보다는 작은 수)
quantile(survey$Pulse, probs=0.05, na.rm=T)
quantile(survey$Pulse, probs=0.5, na.rm=T) # 중위값
quantile(survey$Pulse, probs=c(0.05,0.95), na.rm=T)

# 0, 25, 50,75 100 % 값
quantile(survey$Pulse, na.rm=T)

# 전체의 몇 %가 80이하의 맥박수를 갖는지
mean(survey$Pulse<=80,na.rm = T)

# mean > median -> 오른쪽으로 긴 꼬리
mean(survey$Pulse,na.rm=T)
median(survey$Pulse,na.rm=T)

# ==============================================================================

# 요약 함수 summary()
# summary(숫자벡터): 최소값 1사분위수 중위값 3사분위수 최대값
summary(iris$Sepal.Width)

# summary(팩터벡터): 팩너의 레벨별 빈도
summary(iris$Species)

# summary(문자벡터): 크기(개수), 클래스, 모드 정보
summary(as.character(iris$Species))

# summary(행렬or데이터프레임): 열 단위 요약 통계량
summary(iris)

# lapply() 사용해 리스트 요약통계량 표시
lapply(as.list(iris),summary)

# ==============================================================================

# range(): 가장 큰 값과 가장 작은 값
range(survey$Pulse,na.rm=T)

# var(): 분산
var(survey$Pulse,na.rm=T)

# sd(): 표준편차
sd(survey$Pulse,na.rm=T)

# pastecs 패키지 stat.desc(): 기술 통계량 산출
library(pastecs)
stat.desc(mtcars[c('mpg','hp','wt')])

# psych 패키지 describe(): 기술 통계량 산출
library(psych)
describe(mtcars[c('mpg','hp','wt')])

# ==============================================================================

# 집단별 기술 통계량

# tapply(벡터, INDEX=팩터(그룹화). FUN=적용함수)
tapply(survey$Pulse, INDEX=survey$Exer,FUN=mean,na.rm=T)

# 두개의 집단변수 고려: 집단 구분 변수를 리스트 형식으로 지정
tapply(survey$Pulse, list(survey$Exer, survey$Sex),FUN=mean,na.rm=T)

# aggregate(데이터셋, by=list(고려할 집단변수), FUN=적용함수)
# : tapply()와 출력형태는 다르지만 동일한 결과
aggregate(survey$Pulse,by=list(Exercise=survey$Exer),FUN=mean,na.rm=T)
aggregate(survey$Pulse,by=list(Exercise=survey$Exer,Sex=survey$Sex),FUN=mean,na.rm=T)
# 인수로 데이터셋 사용가능(tapply는 벡터만): 두개 이상의 변수에 대한 집단별 기술통계량을 한꺼번에 계산 가능
aggregate(survey[c("Pulse",'Age')], list(Exercise=survey$Exer),mean,na.rm=T)

# by(데이터셋, INDICES=list(고려할 집단변수), FUN=적용 함수)
# : aggregate()와 동일한 방식으로 작동, 출력형태 다름

# psych 패키지 describeBy(): 집단별 기술 통계량 산출
# describe함수가 제공하는 것과 동일한 기술통계량을 집단별로 산출
# aggregate(), by()와는 달리 별도의 사용자 정의 함수 지정 못함
library(psych)
describeBy(survey[c("Pulse",'Age')], group=list(Exercise=survey$Exer))

# ------------------------------------------------------------------------------
# ==============================================================================































