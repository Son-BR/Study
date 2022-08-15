
# 분산분석

# 4.3 일원분산분석

# 일원분산분석
# 집단을 구분하는 독립변수가 한 개인 경우 모집단 간 평균의 동일성 검정

# ==============================================================================

# 데이터
str(InsectSprays)

# 집단별(살충제별) 요약 통계량
tapply(InsectSprays$count,InsectSprays$spray, length)
tapply(InsectSprays$count,InsectSprays$spray, mean)
tapply(InsectSprays$count,InsectSprays$spray, sd)

# 평균도표: 그룹별 평균과 신뢰구간을 하나의 그래프에
# 각 살충제의 평균과 신뢰구간 시각화
library(gplots)
plotmeans(count~spray,data=InsectSprays,
          barcol='tomato',barwidth = 3,col='cornflowerblue',lwd=2,
          xlab='Type of Sprays', ylab='Insect Count',
          main='Performance of Insect Sprays\nwith 95% CI of Mean')

# 박스도표: 각 그룹별 중위수, 1/3 사분위수, 이상점(outlier) 등을 확인

boxplot(count~spray, data=InsectSprays,
        col='tomato', xlab='Type of Sprays', ylab='Insect Count',
        main='Performance of Insect Sprays')

# aov(종속변수~집단을나타내는독립변수, data=데이터셋): 일원분산분석
# aov 그 자체로는 충분한 정보제공x -> summary(aov객체) 사용(분산분석표)
sprays.aov<-aov(count~spray, data=InsectSprays)
summary(sprays.aov)
# spray행:집단간차이, Residuals행:집단내 차이
# Df:자유도, Sum Sq:제곱합, Mean Sq:분산(제곱합/자유도)
# F Value:F값(spray Mean Sq/Residuals Mean Sq)
# p-value 매우작음(귀무가설 기각)
# 스프레이간 차이가 없다(귀무가설) 기각

# ==============================================================================

# 다중비교

# 위의 귀무가설기각 -> 모집단평균이 모두 동일하다는 주장 기각
#                   -> 어느 집단의 차이로 이러한 결과가 나왔는지는 모름

# model.tables(aov객체, type=타입지정): 개별 집단 간 평균의 차이를 확인

model.tables(sprays.aov, type='mean') # 각 집단의 평균 확인
model.tables(sprays.aov, type='effects') # 집단별 각 집단평균과 전체평균의 차이

# 사후분석(Post-hoc Analysis)
# 두 집단의 차이가 유의미한지 검정
# 터키HSD검정(Tukey Honest Significant Difference Test)

# TukeyHSD(aov객체): 리스트 형식의 모델 객체 반환
# diff:비교쌍간의 평균차이, lwr/upr:95%신뢰구간의 하한값/상한값, p adj:평균차이에 대한 p-value
sprays.compare<-TukeyHSD(sprays.aov)
sprays.compare

# 터키HSD 다중비교: 집단간 차이를 신뢰구간과 함께 나타냄

plot(sprays.compare,col='blue',las=1) # las= : xlable, ylable기울기 조절
# 신뢰구간(그래프의 가로선)이 0을 포함하지 않으면 집단간차이는 통계적으로 유의

# multcomp패키지의 glht()함수
# 다중비교를 위한 좀 더 다양한 방법을 제공
library(multcomp)

# glht(aov객체, linfct=검정할가설)
# mcp(spray='Tukey'): spray변수로 구분되는 집단을 바탕으로 터키HSD 다중비교 수행
# cld(): glht() 함수의 결과 객체로부터 모든 범주쌍의 비교 결과를 알파벳 문자 형식으로 추출
# cld()결과 동일한 문자를 공유하는 집단은 통계적으로 서로 다르지 않음
tuk.hsd<-glht(model=sprays.aov,linfct=mcp(spray='Tukey')) 
plot(cld(tuk.hsd, level=0.05), col='orange')

# ==============================================================================

# 분산분석 가정과 진단

# 분산분석을 위한 관측값의 조건
# 정규성 : 종속변수는 정규분포를 한다.
# 등분산성 : 각 집단의 분포는 모두 동일한 분산을 갖는다.


# 분산분석의 정규성 가정 평가 : 정규Q-Q도표를 이욯하여 평가(car패키지의 qqplot)

library(car)
qqPlot(InsectSprays$count, pch=20, col='deepskyblue', id=FALSE,
       main='Q-Q Plot', xlab='Theoretical Quantiles', ylab='Sample Quantiles')
# 대부분의 관측값 정규성 직선을 따라 분포, 95% 신뢰구간의 범위 내에 위치
# 그러나 동일한 값을 갖고있는 관측값 일부 관찰 -> 정규성 가정의 충족 여부는 명확x

# 샤피로-윌크검정(Shapiro-Wilk Test)
shapiro.test(InsectSprays$count)
# p값이 매우 낮으므로 귀무가설(정규성따른다) 기각

# 이상점 존재여부 평가: car패키지의 outlierTest()
outlierTest(sprays.aov)
# p값이 충분히 큼 : 이상점 포함되어 있지 않다(귀무가설) 채택


# 분산분석의 등분산성 평가: 레벤검정, 바틀렛검정

# 레벤 검정(Levene Test): car 패키지의 leveneTest()
leveneTest(count~spray, data=InsectSprays)
# 바틀렛 검정(Bartlett Test): stats패키지의 bartlett.test()
bartlett.test(count~spray, data=InsectSprays)

# 두 검정 모두 p값 매우 낮음-> 집단간 분산이 동일하다(귀무가설) 기각
# 등분산 가정 충족x -> 일원분산분석을 수행 oneway.test()
# oneway.test()
oneway.test(count~spray, data=InsectSprays)

# aov(), oneway.test() 차이
# aov()는 등분산 가정, oneway.test()는 등분산 가정x
oneway.test(count~spray, data=InsectSprays,var.equal = T) # oneway.test 등분산 가정
summary(aov(count~spray, data=InsectSprays))
# 등분산 가정하면 보다 적극적으로 귀무가설기각 할 수 있음(덜 보수적임)

# ==============================================================================
# ------------------------------------------------------------------------------
