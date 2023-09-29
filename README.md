### Deploying XNAT onto AWS with MonaiLabel

#### 1. XNAT on AWS

#### Security 
On AWS, the basic scan on the docker image returned no issues. However enhanced scanning returned a few vulnerabilities in the list below:

1 to 5 are CRITICAL.

6 to 12 are HIGH.


1. CVE-2016-1000027
2. CVE-2022-22965
3. CVE-2022-22978
4. CVE-2022-1471
5. CVE-2023-40743
6. CVE-2022-28366
7. CVE-2020-25638
8. CVE-2022-24839
9. CVE-2022-29546
10. CVE-2019-0227
11. CVE-2021-22112
12. CVE-2023-2976

Before updating the packages, the initial enhanced scan returned 10+ critical CVEs, after updating most packages, it went down to 5/7 CRITICAL/HIGH. 
Packages which are updated or not are inside Dockerfile, some of it are not updated due to dependencies issues.

ie. XNAT can only run on Java 8 JRE or JDK [1], but spring-web 6.0.0 [2] can only run on Java 17 or later, therefore spring-web is stuck at 4.3.30.RELEASE, which introduces CVE-2016-1000027.

<br>

#### 2. MonaiLabel


<br>

#### References
[1] https://wiki.xnat.org/documentation/xnat-installation-guide

[2] https://spring.io/blog/2022/11/16/spring-framework-6-0-goes-ga
