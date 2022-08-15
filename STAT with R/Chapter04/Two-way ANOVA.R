
# 분산분석

# 4.4 이원분산분석

# 이원분산분석
# 집단을 구분하는 독립변수가 두 개인 경우 모집단 간 경균의 동일성을 검정
# 두 개의 주효과와 하나의 상호작용효과를 검정
# 두 개의 주효과검정: 각 독립변수에 의해 만들어지는 집단 간 평균의 차이에 대한 검정
#                    -> 두 독립변수가 각각 개별적으로 종속변수에 유의한 영향 미치는지 검정
# 상호작용효과 검정: 두 독립변수의 조합에 의해 만들어지는 집단 간 평균의 차이에대한 검정
#                    -> 두 독립변수의 조합이 종속변수와 유의한 영향관계를 갖는지 검정

# ==============================================================================

# 데이터
str(ToothGrowth)

# 투여량 0.5, 1.0, 2.0을 팩터로 변환
ToothGrowth$dose<-factor(ToothGrowth$dose, 
                         levels=c(0.5,1.0,2.0), labels=c('low','med','high'))
str(ToothGrowth)

# 각 집단의 크기와 집단별 평균 및 표준편차
with(ToothGrowth, tapply(len, list(supp,dose), length))
with(ToothGrowth, tapply(len, list(supp,dose), mean))
with(ToothGrowth, tapply(len, list(supp,dose), sd))

# aov(종속변수~독립변수1*독립변수2,data=데이터셋)
# 독립변수1*독립변수2 -> 독립변수1+독립변수2+독립변수1:독립변수2
ToothGrowth.aov<-aov(len~supp*dose, data=ToothGrowth)
summary(ToothGrowth.aov)
# 세 p값 모두 낮으므로 종류, 투여량, 상호작용 모두 영향있음(귀무가설 기각)

# model.tables(): 요약통계량 테이블 형태로
model.tables(ToothGrowth.aov,type='means')

# 상자도표: 주효과 및 상호작용효과 시각적으로 확인
boxplot(len~supp*dose, data=ToothGrowth,
        col=c('deeppink','yellowgreen'), las=1,
        xlab='Bitamin C Type', ylab='Tooth Growth',
        main='Effects of Vitamin C on Tooth Growth of Guinea pigs')
# 투여량 낮음.중간의 경우 OJ가 효과가 좋지만 높음의 경우 비슷해짐

# 상호작용 도표
# interaction.plot(x.factor=x축집단변수, trace.factor=그래프상에 그려질 집단변수,response=종속변수,type=그래프형태)
response=ToothGrowth$len, las=1, type='b',
interaction.plot(x.factor=ToothGrowth$dose, trace.factor=ToothGrowth$supp,
                 response=ToothGrowth$len, las=1, type='b',
                 pch=c(1,19), col=c('blue','red'), trace.label="Supplement",
                 xlab="Dose Level", ylab='Tooth Length',
                 main='Interaction Plot for Tooth Growth of Guinea Pigs')

# 평균도표: 조합별 평균과 신뢰구간, 표본크기 표현
# gplots패키지의 plotmeans() 함수
library(gplots)
plotmeans(len~interaction(supp,dose,sep=' '), data=ToothGrowth,
          connect=list(c(1,3,5), c(2,4,6)), # connect= : 선으로 연결할 집단평균의 인덱스(디폴트T 모두연결) 
          col=c('red','green3'),
          xlab='Supplement and Dose Combination', ylab='Tooth Length',
          main='Means Plot for Tooth Growth of Guinea Pigs\nwith 95% CI of Mean')

# 조건부 도표
# 보충제(supp) 별로 투여량(dose)과 이빨성장(len)간의 관계를 산점도 형태로 표시
# panel=panel.smooth: 점들을 통과하는 직선 추가
coplot(len~dose | supp, data=ToothGrowth,
       col='steelblue', pch=19,
       panel=panel.smooth, lwd=2, col.smooth='darkorange',
       xlab='Dose Level', ylab='Tooth Length')

# 상자도표와 선도표
# HH패키지의 interaction2wt()함수
# 주 효과와 상호작용효과를 동시에 볼수 있는 그래프
library(HH)
interaction2wt(len~supp*dose,data=ToothGrowth)
# 상자도표: 주효과
# 선도표: 상호작용 효과

# ==============================================================================

# 사후분석
TukeyHSD(ToothGrowth.aov)

# which=비교집단선택, conf.level=신뢰구간 선택
TukeyHSD(ToothGrowth.aov, which=c('dose'), conf.level=0.99)

# ==============================================================================
# ------------------------------------------------------------------------------

