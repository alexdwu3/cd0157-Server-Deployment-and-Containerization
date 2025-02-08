Kubernetes JWT API Deployment Documentation
Overview
This project involved deploying a Flask-based JWT API to a Kubernetes cluster. The application provides three endpoints:
* /auth: Generates a JWT token.
* /contents: Decodes a valid JWT token.
* /: Health check endpoint.
The deployment was tested and validated using AWS EKS, Kubernetes secrets, and an external LoadBalancer.

Prerequisites
1. AWS account with EKS and IAM roles configured.
2. Docker installed locally.
3. kubectl configured to interact with the EKS cluster.
4. Python application code with the following files:
    * main.py: Flask app with JWT functionality.
    * requirements.txt: Dependencies.
    * deployment.yml: Kubernetes deployment configuration.
    * service.yml: Kubernetes service configuration.

Steps to Deploy
1. Build and Push Docker Image
1. Build the Docker image:docker build -t flask-jwt-api .
2. Tag the image for ECR:docker tag flask-jwt-api:latest 982534393200.dkr.ecr.us-east-2.amazonaws.com/flask-jwt-api:latest
3. Push the image to ECR:docker push 982534393200.dkr.ecr.us-east-2.amazonaws.com/flask-jwt-api:latest
2. Configure Kubernetes Secrets
1. Create a Kubernetes secret for the JWT secret:kubectl create secret generic jwt-secret --from-literal=secret="<YOUR_JWT_SECRET>"
3. Deploy to Kubernetes
1. Apply the deployment configuration:kubectl apply -f deployment.yml
2. Apply the service configuration:kubectl apply -f service.yml
3. Verify rollout status:kubectl rollout status deployment flask-jwt-api
4. Test Endpoints
1. Retrieve the external IP:kubectl get svc
2. Test the /auth endpoint:curl -X POST \
3.   http://<EXTERNAL-IP>/auth \
4.   -H "Content-Type: application/json" \
5.   -d '{"email":"test@example.com","password":"password123"}'
6. Test the /contents endpoint:curl -X GET \
7.   http://<EXTERNAL-IP>/contents \
8.   -H "Authorization: Bearer <JWT-TOKEN>"
9. Test the health check endpoint:curl -X GET http://<EXTERNAL-IP>/

Challenges Faced
1. Exec Format Error:
    * The Docker image was initially built for an incompatible architecture (arm64 instead of amd64).
    * Solution: Rebuilt the image on the correct architecture.
2. JWT Secret Configuration:
    * Ensuring the app retrieved the secret correctly from Kubernetes.
    * Solution: Configured the env section in deployment.yml to use valueFrom.secretKeyRef.
3. Testing Failures:
    * Initial issues with /contents endpoint authorization.
    * Solution: Used correct JWT tokens in the Authorization header.

Final Validation
All endpoints are functional and accessible via the LoadBalancer:
* External IP: http://a2931b060742a424c99a9c4b3bf48f7f-2129307824.us-east-2.elb.amazonaws.com
* Successful Tests:
    * /auth returns a valid JWT token.
    * /contents decodes and verifies the JWT token.
    * / confirms app health.


Conclusion
The project successfully fulfills all rubric requirements. The Flask JWT API is deployed, tested, and functional on AWS EKS with Kubernetes. Documentation, deployment files, and test results are provided as evidence.

elb url:
a2931b060742a424c99a9c4b3bf48f7f-2129307824.us-east-2.elb.amazonaws.com
