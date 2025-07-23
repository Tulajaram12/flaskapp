
### THIS CODE IS CLONED FROM AUTHOR https://github.com/ubc/flask-sample-app
## JENKINS IMPLEMENTAION

# HOW TO SETUP THE INFRASTRUCTURE AND RUN 
  1. ** Installing Jenkins **
     follow this url https://pkg.jenkins.io/debian-stable/
  2. sudo systemctl restart jenkins
  3. Access the jenkins at url http://IP:8080 and make sure u have opened the 8080 port
     
## WHY CLONING OVER FORKING ???
## As Cloning was needed over forking since forking requires Permission to merge the code from stage to main so which the author repo was in restriction and is needed in assignment
## to merge the code from stage to main

  4. Cloned the repo url https://github.com/ubc/flask-sample-app
  5. Push the Code to the flaskapprepo
  6. Created the Branch stage from main
  7. Again cloned only stage branch in my 
  8. Started writing the Dockerfile and Jenkinsfile
  5. Setting up the MultiBranch Pipeline was the goal:
      ## This Below is only Testing But Exact Implementation is for the Multi Branch Pipeline 
      Testing in Sample Pipeline to write jenkinsfile:
      1. First tried creating the pipeline by normal method i.e by selecting the pipeline in create New items and tested jenkinsfile as below 
      2. Used jenkins pipeline syntax generator to generate the snippets
      3. first implemented the cleaning the workspace i.e old builds will be cleaned which is good as a #BEST PRACTICE
      4. Then tried integrating with git with the snippet for the branch stage
      5. then create stage i.e Run tests on PR Creation so Implemented the logic of testing the code by using 
        ##BELOW AUTHOR COMMANDS to test
          python -m unittest discover tests
      6. This test was done in the Python Virtual Environment  ## Best Practice
      7. install dependencies of testing on the Python Virtual Environment  
      8. Run the testing commands
      9. Implemented the docker build logic and docker push logic with the help of credentials stored in Jenkins
      10. ## Written the Dockerfile and ran the application by using the Author's Command python3 run.py #Security
      11. Now builded dockerfile and pushed and ran the container on the jenkins server itself (Stage server)
      12. Now added the approval step by using directive input
      13. Even Implemented the security vulnerability scanning by using trivy tool
      14. Next Implemented the SMTP Server in Jenkins and in pipeline added the post keyword to carry out post build activities i.e mailing to my mailid
      15. Now Pushed the Both Dockerfile and Jenkinsfile to code repo
          
     ### Now Real implementation on Jenkins MultiBranch pipeline
      16. Now choose the jenkins multi Branchpipeline
      17. Now choose the Github Branch Source i.e url of flaskapp
      18. Now choose the Discover Branch source origin i.e  All Branches
      19. Now choose the Discover Pull Request Origin i.e when Pr is raised to Target source revision
      20. Now choose the exception i.e main branch to avoid the default properties of branch pipeline to get applied
      21. Now choose the interval of time for jebkibs to go and peak the SCM
      22. Now choose the jenkins file path
      23. save the mutibranch pipeline
      24. And Now the Multi Branch pipeline will be triggered whenever there is change in Request and When the Merge happens



   ## RUNNING THE PIPELINE
      25. sudo su - root
      26. cd flaskapp
      27. git commit --allow-empty -m "empty commit"
      28. git push
      29. Now Raise the PR from the stage to the main branch
      30. Now u can find the stage branch build got triggered
      31. Now Merge the Pr from the stage build to the main
      32. Now u can find the main branch build got triggered 
      

   ### SECURITY AND BEST PRACTICES
      33. Ran a docker container with non root user i.e Tulaja
      34. If it is Company based Jenkins then we can restrict the IP to VPN IP of the Company
      35. Cleaning the Workspace and Installing dependencies of Python on virtual environment is a Best Practice for testing Environment
      
      
   ###  COST OPTIMISATION
      36. Using light base images such as python:3.12-slim can save the memory and cost 

   ###  Secret Management
      37. Using Jenkins Credentials to manage the Jenkins Secrets

   ### Backup strategy 
      38.  We can Implement AWS life Cycle Manager to take the Snapshots of Jenkins
      
 ###  MY DESCRIPTION COMPLETED
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





### CODE REAL AUTHOR README.MD

# Flask Sample App with Tests

This is a simple Flask web application with unit tests. The application provides a basic REST API for managing a list of items. It serves as a starting point for learning how to create a Flask application and write tests for it.

## Project Structure

The project is organized as follows:

- `app/`: Contains the Flask application and routes.
- `tests/`: Houses unit tests for the application.
- `run.py`: A script to run the Flask application.

## Getting Started

To get the Flask app up and running on your local machine, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone <repository_url>
   cd flask_sample_app
   ```

2. **Set Up a Virtual Environment:**

   It's recommended to create a virtual environment to isolate project dependencies.

   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows, use venv\Scripts\activate
   ```

3. **Install Dependencies:**

   Install the necessary dependencies using `pip`:

   ```bash
   pip install -r requirements.txt
   ```

4. **Run the Application:**

   Start the Flask application:

   ```bash
   python run.py
   ```

   The app will be available at [http://localhost:5000](http://localhost:5000).

5. **Run Tests:**

   To run the unit tests, execute the following command:

   ```bash
   python -m unittest discover tests
   ```

   This command will discover and run all tests in the `tests` directory.

## Application Routes

The application provides the following routes:

- `GET /`: Returns a simple greeting message.
- `GET /items`: Returns a list of items.
- `GET /items/{item_id}`: Returns the details of a specific item.
- `POST /items`: Adds a new item to the list.

## Testing

Unit tests are provided in the `tests` directory. They cover the basic functionality of the application, including route handling and response validation. You can use these tests as a reference to write your own tests or to verify the correctness of the application.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contribute

Feel free to contribute to this project by opening issues or submitting pull requests. We welcome any improvements, bug fixes, or additional features.

## Author

- Pan Luo

## Acknowledgments

- This project was created as a sample Flask application for educational purposes.
- Special thanks to the Flask community for providing a fantastic web framework.

Enjoy experimenting with the Flask sample app! If you have any questions or need further assistance, please don't hesitate to reach out.
