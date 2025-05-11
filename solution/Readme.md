# CSV Server Solution

1. Run the container image `infracloudio/csvserver:latest` in the background and check if it's running:

    ```bash
    docker container run -d --name mycontainer infracloudio/csvserver:latest 
    ```

2. If it's failing, then try to find the reason. Once you find the reason, move to the next step:

    ```bash
    docker ps -a
    docker container logs mycontainer
    2025/05/11 10:58:42 error while reading the file "/csvserver/inputdata": read /csvserver/inputdata: no such file or directory
    ```

3. Running the script with two arguments as `./gencsv.sh 2 8` should generate the file `inputFile` with 7 such entries in the current directory. The index of the first entry is 2, and the last entry is 8:

    ```bash
    chmod +x gencsv.sh
    ./gencsv.sh 2 8
    ```

4. Run the container again in the background with the file generated in (3) available inside the container (remember the reason you found in (2)):

    ```bash
    docker container run -d -v "$(pwd)/inputFile:/csvserver/inputdata" --name mycontainer infracloudio/csvserver:latest
    ```

5. Get shell access to the container and find the port on which the application is listening. Once done, stop/delete the running container:

    ```bash
    docker exec -it mycontainer /bin/bash

    netstat -tnlp  # Run this command inside the container
    ```

    Look for lines with `LISTEN` in the output; the port number will be displayed after the colon (e.g., `0.0.0.0:9300` means the application is listening on port `9300`).

6. Same as (4), run the container and make sure:

    a. The application is accessible on the host at `http://localhost:9393`.  
    b. Set the environment variable `CSVSERVER_BORDER` to have the value `Orange`.

    ```bash
    docker container run -d -v "$(pwd)/inputFile:/csvserver/inputdata" -p 9393:9300 -e CSVSERVER_BORDER=Orange --name mycontainer infracloudio/csvserver:latest
    ```