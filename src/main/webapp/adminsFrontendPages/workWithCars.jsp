<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.company.entity.Car" %>
<%@ page import="com.company.controller.DatabaseController" %>
<%@ page import="com.company.enums.CarStatus" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cars</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark  justify-content-center text-white navbar-dark">
    <div class="container-fluid">
        <ul class="navbar-nav ">
            <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/adminCabinet" class="nav-link">Home</a>
            </li>
            <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/addCar" class="nav-link" >Add Car</a>
            </li>
            <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/showOrders" class="nav-link" >Show orders</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/showAllCars" class="nav-link">Show all cars</a>
            </li>
            <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/WWADMIN" class="nav-link" >Work with admin</a>
            </li>
            <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/FileUploadServlet" class="nav-link" >Add Photo to car</a>
            </li>
            <li class="nav-item  ">
                <a href="${pageContext.request.contextPath}/logout" class="nav-link ">Logout</a></li>
        </ul>
    </div>
</nav>
<h1 class="text-center">Cars</h1>
<br>

<%! List<String> imagesUrl = new ArrayList<>();%>
<% if (request.getAttribute("isDeleted") != null) {%>
<h4 class="text-center"><%= request.getAttribute("isDeleted")%>
</h4>
<br>
<% }%>
<%! Object cars = new ArrayList<>(); %>
<%cars = request.getAttribute("cars");%>
<form method="post" action="${pageContext.request.contextPath}/showAllCars">
    <div class="container-fluid">
        <div class="row">
            <% for (Car car : (List<Car>) cars) {
                imagesUrl = DatabaseController.getImagesByCarNumber(car.getCarNumber());%>
            <div class="card col-3">
                <form method="post" action="${pageContext.request.contextPath}/showAllCars">
                    <div id="<%=car.getCarNumber()%>" class="carousel slide" data-bs-ride="carousel">
                        <%for (int i = 0; i < imagesUrl.size(); i++) { %>
                        <div class="carousel-indicators">
                            <button type="button"
                                    <%if (i == 0) {%>
                                    class="active"<%}%>
                                    data-bs-target=<%="#"+car.getCarNumber()%> data-bs-slide-to=<%=i%>  >
                            </button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item <% if (i == 0) {%> active<%}%>">
                                <img src="<%="carPhotos"+imagesUrl.get(i).substring(imagesUrl.get(i).lastIndexOf("/"))%> "
                                     alt="<%=car.getCarModel()%>"
                                     class="d-block w-100" height="250">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button"
                                data-bs-slide="prev" data-bs-target=<%="#" + car.getCarNumber()%>>
                            <span class="carousel-control-prev-icon"></span>
                        </button>
                        <button class="carousel-control-next" type="button"
                                data-bs-slide="next" data-bs-target=<%="#" + car.getCarNumber()%>>
                            <span class="carousel-control-next-icon"></span>
                        </button>
                        <%}%>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title">Model: <%=car.getCarModel()%>
                        </h4>
                        <h5 class="card-text"><input type="hidden" name="deleteCarNumber"
                                                     value="<%=car.getCarNumber()%>">Number: <%=car.getCarNumber()%>
                        </h5>
                        <h5 class="card-text">Region: <%=car.getCarRegion()%>
                        </h5>
                        <h5 class="card-text">Color: <%=car.getCarColor()%>
                        </h5>
                        <h5 class="card-text">Year: <%=car.getCarYear()%>
                        </h5>
                        <h5 class="card-text">Count of place: <%=car.getCountOfPlace()%>
                        </h5>
                        <h5 class="card-text">Price per day: <%=car.getPricePerDay()%>
                        </h5>
                        <h5 class="card-text">Car status <%=car.getCarStatus()%></h5>
                        <%if (car.getAdditionInfo() != null) {%>
                        <h5 class="card-text">Info: <%=car.getAdditionInfo()%>
                        </h5>
                        <%}%>
                        <button class="  btn btn-danger  " name="command" value="delete" type="submit">Delete</button>
                        <%if (car.getCarStatus().equals(CarStatus.BROKEN)) {%>
                        <button class="  btn btn-primary " name="command" value="repair" type="submit">Repaired</button>
                        <%}%>
                    </div>
                </form>
            </div>

            <%}%>

        </div>

    </div>
</form>
</body>
</html>
