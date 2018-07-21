install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
install.packages("data.table")
install.packages("dplyr")

library(rJava)
library(DBI)
library(RJDBC)
library(data.table)
library(dplyr)


drv <- JDBC(
  "oracle.jdbc.driver.OracleDriver",
  "C:\\R\\project\\ojdbc6.jar"
)
conn <- dbConnect(drv,
                  "jdbc:oracle:thin:@localhost:1521:xe",
                  "hr",
                  "oracle")
tab <- dbGetQuery(conn, "SELECT * FROM TAB")
View(tab)
 tname <- tab$TNAME
 tname
 
 # COUNTRIES -> cnt
 # DEAPRTMENTS -> dep
 # EMPLOYEES ->emp
 # EMP_DETAILS_VIEW ->empd
 # JOBS ->job
 # JOB_HISTORY -> jobh
 # LOCATIONS -> loc
 # REGIONS -> reg
 getwd()
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM COUNTRIES"))
 View(cnt) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM DEAPRTMENTS"))
 View(dep) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM EMPLOYEES"))
 View(emp) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM EMP_DETAILS_VIEW"))
 View(empd) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM JOBS"))
 View(job) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM JOB_HISTORY"))
 View(jobh) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM LOCATIONS"))
 View(loc) 
 cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM REGIONS"))
 View(cnt) 
 emp %>%
   select(everything()) %>%
   slice(1:3)
 
 
 # EMPLOYEE_ID
 # FIRST_NAME
 # LAST_NAME
 # EMAIL
 # PHONE_NUMBER
 # HIRE_DATE
 # JOB_ID
 # SALARY
 # COMMISSION_PCT
 # MANAGER_ID
 # DEPARTMENT_ID
 
 
 ## 문제1) 사원의 First Name 과 Last Name 을
 ## 붙여서 Name 으로 된 컬럼을 추가하시오
 ## 단, 이름 간격은 띄울것. ex) James Dean

 paste("James", "Dean")
 
  cnt <-  data.frame(dbGetQuery(conn, "SELECT * FROM EMPLOYEE_ID"))
 View(cnt) 
 
 
 ## 문제2) SALARY 는 연봉(달러)을 말합니다.
 ## 경리부에서 매달 지급하는 월급여를 
 ## 알려달라고 하여 MONTH_SAL 이라는 컬럼을
 ## 추가 시켜주세요.
 
 
 
 ## 문제3). 경리부에서 급여가 20000불 이상인
 ## 사원의 목록을 NAME, EMPLOYEE_ID, SALARY 
 ## 만 보여주세요.
 emp %>%
   select(LAST_NAME, EMPOYEE_ID, SALARY) %>%
   filter(SALARY >= 20000)
 
  
 ## 문제 4. 경리부에서 급여가 7000불 이하인
 ## 사원에게 보너스로 급여의 10%를 더 지급하
 ## 겠다고 합니다. 이번달에 보너스가 추가된
 ## 대상자의 목록을 NAME, EMPLOYEE_ID, SALARY
 ## 만 보여주세요.
 
 
 
 ## 문제 5. 직원중에서 성(LAST_NAME) 에 e  또는
 ## o 가 포함된 직원을 출력하시오.  
  
  
 ## 문제6) 직원중에서 급여가 가장 높은 사람이 CEO라고 합니다. 이름이 무엇입니까?
 ## apply(object, direction, function to apply)
 ## 적용방향 -1:가로방향, 2: 세로방향
 ceo_sal <-apply(emp %>%
                   select(SALARY), 2, max)
 ceo_sal
  
  
  
  
   
  
  