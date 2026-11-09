## Start

```bash
docker compose up -d --build
```

- Forma: http://localhost:8080/

## Other command

```bash
docker compose ps                 
docker compose logs -f app        
docker compose logs -f db         
docker compose up -d --build app  
docker compose down               
docker compose down -v            
```

Control:

```bash
curl -i -X POST -d "name=Test&email=t@example.com&description=hello" http://localhost:8080/save
curl http://localhost:8080/home
```

Connect DB:

```bash
docker compose exec db mysql -u appuser -papppass appdb -e "select * from user;"
```
