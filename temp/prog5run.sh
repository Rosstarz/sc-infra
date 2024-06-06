logging:
  level:
    com:
      ross: TRACE

--entrypoint java -Dspring.profiles.active=dev -jar /prog5.jar


registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5

docker run --name tester --entrypoint java registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5 -Dspring.profiles.active=dev -jar /prog5.jar -e DB_URL=jdbc:postgresql://prog5-prog5-db-1:5432/prog -e DB_USERNAME=postgres -e DB_PASSWORD=Student1234

docker run --name tester --network prog5_default -e DB_USERNAME=postgres -e DB_PASSWORD=Student1234 -e DB_ADDRESS=prog5-prog5-db-1 -e DB_PORT=5432 -e DB_NAME=prog registry.gitlab.com/kdg-ti/programming-5/projects-23-24/acs202/rostislav.rucka/programming-5
