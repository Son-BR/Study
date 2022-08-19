
# 독립성검정과 적합성검정

# 5.1 x^2(카이스퀘어) 검정

# x^2검정
# 범주형 변수간의 관련성 확인
# x^2검정은 교차표상의 응답 빈도를 바탕으로 수행

# 데이터 생성

# 부상 정도와 안전벨트 착용 유무
survivors<-matrix(c(1443,151,47,1781,312,135), ncol=2)
dimnames(survivors)<-list('Status'=c('minor injury', "serious injury", 'dead'),
                          "Seatbelt"=c('with seatbelt', 'without seatbelt'))
survivors

# addmargins(데이터셋, margin=): margin=1:행, 2:열 
addmargins(survivors)
addmargins(prop.table(addmargins(survivors,2),2),1)

# 그래프 생성

# 빈도 막대그래프
barplot(survivors, ylim=c(0,2500), las=1,
        col=c('yellowgreen', 'lightsalmon', 'orangered'),
        ylab='Frequency', main='Frequency of Survivors')
# 범례
legend(0.2, 2500, rownames(survivors),
       fill=c('yellowgreen', 'lightsalmon', 'orangered'))

# 비율 막대그래프
survivors.prop<-prop.table(survivors, 2)
barplot(survivors.prop*100, las=1, col=c('yellowgreen', 'lightsalmon', 'orangered'),
        ylab='Percent', main='Percent of Survivors')

# ==============================================================================

# 기대빈도와 관측빈도

# 관측빈도(Observed Count): 실제 관측된 빈도
# 관측빈도(Expected Count): 귀무가설이 사실이라는 가정하에서 기대할 수 있는 빈도
#                           (부상정도와 안전벨트 착용여부는 관련 없다)

# x^2검정 절차는 기대빈도와 관측빈도의 비교를 통해 계산되는 x^2값을 이용하여 수행
# 표본으로부터 산출된 x^2값이 귀무가설이 사실이라는 가정하에 x^2분포상에서 
# 얼마나 나타나기 어려운 희박한 경우인지 혹은 흔하게 관찰될 수 있는 경우인지 평가

# x^2분포의 자유도는 교차표를 구성하느 두 변수의 범주의 개수에 의해 결정
# (행 변수의 범주의 개수-1)*(열 변수의 범주의 개수-1)
# x^2분포: 범주의 개수에 따른 자유도에 의해 분포의 모양이 결정, 대체로 오른쪽으로 긴 꼬리

# 귀무가설이 사실이면 x^2값은 0에 가까운 작은 값을 가짐
# 왜냐하면 귀무가설이 사실일 경우 관측빈도는 기대빈도와 유사한 값을 가질것으로 예상

# x^2값 45.91, 자유도2에 대응되는 유의확률
pchisq(45.91, df=2, lower.tail=F)
# 0.05보다 훨씬 작으므로 귀무가설 기각

# 0.05유의 확률에 대응되는 x^2값
qchisq(0.05, df=2, lower.tail=F)

# ==============================================================================

# 5.2 독립성검정

# 독립성검정
# 두 범주형 변수가 서로 독립인지(두 변수가 서로 관련이 없는지) 검정
# x^2검정 절차에 따라 두 변수의 범주 조합별 빈도를 기록한 교차표를 토대로 수행

# ==============================================================================

# 데이터
str(Titanic)

# 승객 구분에 따라 생존율 차이가 있는지 검정
# margin.table(데이터셋, margin=교차표만들 열 선택)
Titanic.margin<-margin.table(Titanic, margin=c(4,1))

# 행과 열의 합, 열의비율 추가
addmargins(Titanic.margin)
addmargins(prop.table(addmargins(Titanic.margin, 2), 2), 1)

# 독립성 검정
chisq.test(Titanic.margin)
# p값 매우 작으므로 귀무가설(승객구분과 생존여부는 관련없다) 기각

# 관련성 강도 평가
# vcd패키지 assocstats(): 지표들의 값이 클수록 관련성이 큼(Phi-Coefficient, Contingency Coeff, Cramer`s V`)
library(vcd)
assocstats(Titanic.margin)

# 모자이크 도표(시각화)
library(vcd)
mosaic(Titanic.margin, shade=T, lengend=T)
mosaic(~Survived+Class, data=Titanic.margin, shade=T, lengend=T)
page115
# ==============================================================================


# ==============================================================================
# ------------------------------------------------------------------------------














