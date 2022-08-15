
# 평균검정

# 평균검정: 평균에 대한 가설검정
#           표본이 특정 평균값을 갖는 모집단에 속하는지(표본의 평균과 모집단의 평균이 동일한지)
#           두 표본집단의 평균값 간에 차이가 존재하는지(두 표본집단이 동일한 모집단에 속하는지)

# ------------------------------------------------------------------------------

# 3.1 t검정

# t검정: 평균에 대한 가설검정, 
#        표본평균이 모집단평균과 동일한지 여부를 t값을 검정통계량으로 사용하여 검정
# t분포: t값이 따르는 분포, 종모양의 형태를 가지며 표본크기(자유도)에 따라 모양이 달라짐
#        자유도 클 수록 뾰족해지고 작을수록 꼬리부분의 면적이 커짐

# pt(관측값(t값),df=자유도)

# t>=3.58, t<=-3.58 일 확률
pt(3.58,df=19,lower.tail=F)*2

# qt(확률,df=자유도)

# 자유도 19일때 0.025 확률이 나오는 q값
qt(0.025, df=19, lower.tail=F)

# ------------------------------------------------------------------------------

# 3.2 일표본 평균검정

# 일표본 평균검정(one-sample t test)
# 하나의 표본 데이터를 이용하여 모집단의 평균이 특정 값과 같은지 검정
# 표본집단이 특정 모집단과 일치하는지 혹은 그렇지 않은지 알고 싶을 때 이용

# 데이터
library(MASS)
str(cats)

# t.test(데이터셋, mu=모집단평균)

# 고양이의 몸무게가 2.6kg인지 검정(귀무가설)
t.test(x=cats$Bwt,mu=2.6) 
# 귀무가설 기각(p-value가 너무 작으므로 고양이 몸무게 2.6kg 아니라고 결론)

# 고양이의 몸무게가 2.7kg인지 검정(귀무가설)
t.test(x=cats$Bwt,mu=2.7) 
# 귀무가설 지지(고양이 무게가 2.7kg)

# t.test는 기본적으로 양측검정
# 단측검정 수행하려면 alternative='greater' 또는 'less'

# 고양이의 평균 몸무게는 2.6보다 작거나 같다.(귀무가설)
t.test(x=cats$Bwt,mu=2.6, alternative = 'greater') # 귀무가설 기각

# t.test() 객체: 리스트형태, 추출가능
cats.t<-t.test(x=cats$Bwt,mu=2.6, alternative = 'greater')
str(cats.t)

cats.t$p.value # p값
cats.t$conf.int # 신뢰수준 0.95의 신뢰구간 

# 신뢰수준 99% 지정
t.test(cats$Bwt, mu=2.6, conf.level=0.99)

# prop.test(x=성공횟수,n=시행횟수,p=검정비율)

# 30경기 중 18경기를 우승, 승률 50% 이상?
prop.test(x=18,n=30,p=0.5,alternative="greater") # 귀무가설(안넘는다)채택

# ------------------------------------------------------------------------------

# 3.3 독립표본 평균검정

# 독립표본 평균검정(Two-independent Samples T Test)
# 두 개의 독립표본 데이터를 이용하여 각각 대응되는 두 개의 모집단평균이 서로 동일한지 검정

# ==============================================================================

# t.test(formula=종속변수~독립변수,data=데이터셋)

# 고양이의 성별에 따라 무게 차이가 있다.(대립가설)
t.test(formula=Bwt~Sex,data=cats) # 귀무가설(차이없다)기각

Bwt.f<-cats$Bwt[cats$Sex=='F']
Bwt.m<-cats$Bwt[cats$Sex=='M']
t.test(Bwt.f,Bwt.m)

# 시각적으로 확인
bars<-tapply(cats$Bwt, cats$Sex, mean)
lower<-tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[1])
upper<-tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[2])

library(gplots)
barplot2(bars, space=0.4, ylim=c(0,3.0),
         plot.ci = T, ci.l=lower, ci.u=upper, ci.color = 'maroon', ci.lwd=4,
         names.arg=c('Female', 'Male'), col=c('coral','darkkhaki'),
         xlab="Cats", ylab='Body Weight (kg)',
         main='Body weight by Sex/nwith Confidence Interval')
# 암컷 고양이와 수컷 고양이의 평균몸무게의 신뢰구간 서로 겹치지 않음을 시각적으로 확인

# ==============================================================================

# 집단간 비율 검정

smokers<-c(83,90,129,70) # 각 병원의 흡연자 수
patients<-c(86,93,136,82) # 각 병원의 환자 수수

# prop.test(x=사건발생횟수,n=대응집단크기)
prop.test(x=smokers,n=patients)
# 네 병원의 폐질환자 대비 흡연자수의 비율이 같다(귀무가설) 기각

# ------------------------------------------------------------------------------

# 3.4 대응표본 평균검정

# 대응표본 평균검정(Paired-samples T Test)
# 두 개의 표본이 서로 독립이 아닌 모집단으로부터 추출시 사용(독립표본 평균검정 사용 불가)
# 약물 복용여부에 땨른 두 집단 -> 독립표본
# 한 집단 약물 복용 전후 비교 -> 대응표본

# ==============================================================================

# 데이터
str(sleep)

# t.test(종속변수~독립변수,data=데이터셋, paired=대응표본여부)

# 수면제 사용 여부에 따른 수면시간 차이
t.test(extra~group, data=sleep,paired=T) # 귀무가설(차이없다) 기각


# ==============================================================================

# 롱 포멧(Long Format) & 와이드 포멧(Wide Format)

# t.test()에 포물러 형식으로 인수지정 위해서는 롱포멧으로 데이터가 저장되어 있어야 함

# 포멧 변경하기
library(tidyr)

# 롱(long) -> 와이드(wide)
# spread(데이터셋, key=분리기준, value=넣을값)
sleep.wide<-spread(sleep,key=group,value=extra)
sleep.wide

# 와이드(wide) 포멧 t.test(): 인수 각각 지정
t.test(sleep.wide$'1',sleep.wide$'2',paired=T)

# ------------------------------------------------------------------------------
# ==============================================================================

