
# 가설검정과 확률분포

# 2.1 가설검정

# ==============================================================================

# 가설검정(Hypothesis Test)
# 표본데이터를 기반으로 모집단에 대한 새로운 주장의 옳고 그름을 추론하는 과정

# 대립가설: 모집단에 대한 새로운 주장
# 귀무가설: 일반적인 사실로 받아들여지는 기존의 주장
# => 대립가설을 새로운 사실로 받아들이기 위해서는 기존의 주장이 명백히 잘못되었음을 증명해야 함
# => 가설검정

# ------------------------------------------------------------------------------

# 2.2 확률분포

# unif() : 균일분포
# binom() : 이항분포
# norm() : 정규분포
# t() : t분포
# f() : f분포
# chisq() : x^2(카이제곱)분포

# d(density) : 확률밀도함수(x값에 대응되는 y값)
# p(probability) : 누적확률함수
# q(quantile) : 백분위수함수
# r(random) : 난수생성함수

# 도움말
# ?Unifrom ?Binomial ?Normal ?TDist ?FDist ?Chisquare 

# ==============================================================================

# 이항분포

# dbinom(사건발생횟수, size=시행횟수, prob=확률)

# 동전던지는 실험 10번 했을 때 7번 앞면일 확률
dbinom(7,size=10,prob=0.5)

# 동전던지는 실험 10번 했을 때 앞면 7번 이하 누적확률
pbinom(7,size=10,prob=0.5)
sum(dbinom(0:7,size=10,prob=0.5)) # 0~7까지 나올확률의 합

# 8번 이상 나올확률(7이하의 반대편 영역)
pbinom(7,size=10,prob=0.5,lower.tail = F)

# 4번 이상 7번 이하 확률률
pbinom(7,size=10,prob=0.5)-pbinom(3,size=10,prob=0.5)

# 누적확률 한번에 구하기
pbinom(c(3,7),size=10,prob=0.5)

# diff() 두 관측값 간의 구간확률
diff(pbinom(c(3,7),size=10,prob=0.5))

# 이항분포 난수 생성
# rbinom(생성할난수개수, size=시행횟수, prob=확률)
rbinom(5,size=10,prob=0.5)

# ==============================================================================

# 정규분포 

# pnorm((계산하고자하는)관측값, mean=평균, sd=표준편차)
# 디폴트: mean=0, sd=1 (표준정규분포)

# IQ가 평균 100 표준편차 15의 정규분포를 따를때 110이하일 확률
pnorm(110,mean=100,sd=15)

# 이상일 확률(1-이하일확률)
pnorm(110,mean=100,sd=15,lower.tail = F)

# 110일 확률
dnorm(110,mean=100,sd=15)

# 90이상 110이하일 확률
pnorm(110,mean=100,sd=15)-pnorm(90,mean=100,sd=15)
diff(pnorm(c(90,110),mean=100,sd=15))

# qnorm(누적확률, mean=평균, sd=표준편차)

# 누적확률 0.05,0.95인 IQ값
qnorm(0.05,mean=100,sd=15) # 75 
qnorm(0.95,mean=100,sd=15) # 125
qnorm(c(0.05,0.95),mean=100,sd=15)

# rnorm(생성할난수개수, mean=, sd=)
rnorm(1,mean=100,sd=15)
rnorm(5,mean=100,sd=15)
rnorm(1)
rnorm(3,mean=c(-10,0,10),sd=1)

# ==============================================================================

# shapiro.test(): 데이터의 정규성 검정
# 귀무가설이 정규성을 따른다이기 때문에 p-value 0.05 이상이면 정규분포를 따름
set.seed(123)
shapiro.test(rnorm(100,mean=100,sd=15))

shapiro.test(runif(100,min=2,max=4))

# qqnorm(): 정규Q-Q도표를 통해 데이터의 정규성 시각적으로 확인
# 점들이 직선에 가까워 질수록 데이터 표본은 정규분포에 근접
set.seed(123)
qqnorm(rnorm(100,mean=100,sd=15),col='blue',
       main='Sample from Normal Distribution')
qqline(rnorm(100,mean=100,sd=15),col='blue',
       main='Sample from Normal Distribution')

qqnorm(runif(100,min=2,max=4),col='red',
       main='Sample from Uniform Distribution')
qqline(runif(100,min=2,max=4))



# ------------------------------------------------------------------------------
# ==============================================================================





























