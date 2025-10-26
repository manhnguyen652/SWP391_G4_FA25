<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Shipper Profile</title>
    <style>
        .container { width: 60%; margin: 30px auto; background: #fff; padding: 20px; border-radius: 10px; }
        .btn-primary { background: #7bb241; border: none; padding: 8px 15px; color: white; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>My Profile</h2>
        <form action="shipperProfile" method="post">
            <input type="hidden" name="id" value="${shipper.id}">
            <label>Phone:</label><br>
            <input type="text" name="phone" value="${shipper.phone}" class="form-control"><br>
            <label>Vehicle Number:</label><br>
            <input type="text" name="vehicle" value="${shipper.vehicleNumber}" class="form-control"><br>
            <label>Region:</label><br>
            <input type="text" name="region" value="${shipper.region}" class="form-control"><br>
            <button class="btn-primary" type="submit">Update</button>
            <a href="shipping" class="btn-primary">Back to Shipping</a>
        </form>
    </div>
</body>
</html>
