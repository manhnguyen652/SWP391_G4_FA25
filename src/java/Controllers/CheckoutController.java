//package Controllers;
//
//import DAO.CartDAO;
//import DAO.OrderDAO;
//import DAO.UserInformationDAO;
//import model.Account;
//import model.CartItemDTO;
//import model.Order;
//import model.UserInformation;
//import com.vnpay.common.Config;
//
//import java.io.IOException;
//import java.util.List;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.util.ArrayList;
//import java.net.URLEncoder;
//import java.nio.charset.StandardCharsets;
//import java.text.SimpleDateFormat;
//import java.util.Calendar;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.Map;
//import java.util.TimeZone;
//
//@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
//public class CheckoutController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        HttpSession session = request.getSession();
//        Account account = (Account) session.getAttribute("account");
//        if (account == null) {
//            response.sendRedirect("login-register");
//            return;
//        }
//
//        @SuppressWarnings("unchecked")
//        List<Integer> selectedItemIds = (List<Integer>) session.getAttribute("selectedCheckoutItems");
//        if (selectedItemIds == null || selectedItemIds.isEmpty()) {
//            response.sendRedirect("cart?error=noselection");
//            return;
//        }
//
//        CartDAO cartDAO = new CartDAO();
//        List<CartItemDTO> checkoutItems = cartDAO.getCartItemsByIds(selectedItemIds);
//        if (checkoutItems == null || checkoutItems.isEmpty()) {
//             response.sendRedirect("cart?error=itemnotfound");
//            return;
//        }
//
//        double subTotal = 0;
//        for (CartItemDTO item : checkoutItems) {
//            subTotal += item.getTotal();
//        }
//        double shippingFee = 0;
//        double grandTotal = subTotal + shippingFee;
//
//        request.setAttribute("checkoutItems", checkoutItems);
//        request.setAttribute("checkoutSubTotal", subTotal);
//        request.setAttribute("checkoutShippingFee", shippingFee);
//        request.setAttribute("checkoutGrandTotal", grandTotal);
//
//        UserInformationDAO infoDAO = new UserInformationDAO();
//        List<UserInformation> savedAddresses = infoDAO.getAllUserInfo(account.getU_id());
//        request.setAttribute("savedAddresses", savedAddresses); 
//
//        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        request.setCharacterEncoding("UTF-8");
//        String action = request.getParameter("action");
//        
//        if ("placeOrder".equals(action)) {
//            HttpSession session = request.getSession();
//            Account account = (Account) session.getAttribute("account");
//
//            if (account == null) {
//                response.sendRedirect("login-register");
//                return;
//            }
//
//            @SuppressWarnings("unchecked")
//            List<Integer> selectedItemIds = (List<Integer>) session.getAttribute("selectedCheckoutItems");
//            if (selectedItemIds == null || selectedItemIds.isEmpty()) {
//                response.sendRedirect("cart?error=noselection");
//                return;
//            }
//            
//            CartDAO cartDAO = new CartDAO();
//            OrderDAO orderDAO = new OrderDAO();
//            UserInformationDAO infoDAO = new UserInformationDAO();
//            List<CartItemDTO> checkoutItems = cartDAO.getCartItemsByIds(selectedItemIds);
//
//            if (checkoutItems == null || checkoutItems.isEmpty()) {
//                 response.sendRedirect("cart?error=itemnotfound");
//                return;
//            }
//
//            Order order = new Order();
//            order.setUId(account.getU_id());
//
//            order.setShip_lname(request.getParameter("lastName"));
//            order.setShip_fname(request.getParameter("firstName"));
//            order.setShip_email(request.getParameter("email"));
//            order.setNote(request.getParameter("orderNote"));
//
//            String addressSelection = request.getParameter("addressSelection");
//            
//            if ("new".equals(addressSelection)) {
//                String newPhone = request.getParameter("new_phone");
//                String newCountry = request.getParameter("new_country");
//                String newAddress = request.getParameter("new_address");
//                
//                order.setShip_phone(newPhone);
//                order.setShip_address(newAddress);
//                order.setShip_country(newCountry);
//                
//                UserInformation newInfo = new UserInformation();
//                newInfo.setU_id(account.getU_id());
//                newInfo.setPhone(newPhone);
//                newInfo.setCountry(newCountry);
//                newInfo.setAddress(newAddress);
//                infoDAO.addUserInfo(newInfo);
//                
//            } else {
//                try {
//                    int selectedAddressId = Integer.parseInt(addressSelection);
//                    UserInformation savedInfo = infoDAO.getSingleUserInfo(selectedAddressId);
//                    
//                    if (savedInfo != null && savedInfo.getU_id() == account.getU_id()) {
//                        order.setShip_phone(savedInfo.getPhone());
//                        order.setShip_address(savedInfo.getAddress());
//                        order.setShip_country(savedInfo.getCountry());
//                    } else {
//                        throw new Exception("Security Error: User tried to use an address not belonging to them.");
//                    }
//                } catch (Exception e) {
//                     e.printStackTrace();
//                     response.sendRedirect("checkout?error=addressfail");
//                     return;
//                }
//            }
//            
//            double subTotal = 0;
//            for (CartItemDTO item : checkoutItems) {
//                subTotal += item.getTotal();
//            }
//            double shippingFee = 0;
//            double grandTotal = subTotal + shippingFee;
//            order.setTotalAmount(grandTotal);
//
//            int newOrderId = orderDAO.createOrder(order);
//            if (newOrderId == -1) {
//                response.sendRedirect("checkout?error=orderfail");
//                return;
//            }
//
//            orderDAO.addOrderDetails(checkoutItems, newOrderId);
//            // KHÔNG xóa giỏ hàng ở đây - sẽ xóa sau khi thanh toán thành công
//            // Giữ selectedCheckoutItems trong session để xóa sau khi thanh toán thành công
//
//            String vnp_Version = "2.1.0";
//            String vnp_Command = "pay";
//            String vnp_OrderType = "other";
//            long amount = (long) grandTotal * 100;
//            String vnp_TxnRef = String.valueOf(newOrderId);
//            String vnp_IpAddr = Config.getIpAddress(request);
//            String vnp_TmnCode = Config.vnp_TmnCode;
//
//            Map<String, String> vnp_Params = new HashMap<>();
//            vnp_Params.put("vnp_Version", vnp_Version);
//            vnp_Params.put("vnp_Command", vnp_Command);
//            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
//            vnp_Params.put("vnp_Amount", String.valueOf(amount));
//            vnp_Params.put("vnp_CurrCode", "VND");
//            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
//            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang " + newOrderId);
//            vnp_Params.put("vnp_OrderType", vnp_OrderType);
//            vnp_Params.put("vnp_Locale", "vn");
//            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
//            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
//
//            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
//            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
//            String vnp_CreateDate = formatter.format(cld.getTime());
//            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
//
//            cld.add(Calendar.MINUTE, 15);
//            String vnp_ExpireDate = formatter.format(cld.getTime());
//            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
//
//            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
//            Collections.sort(fieldNames);
//            StringBuilder hashData = new StringBuilder();
//            StringBuilder query = new StringBuilder();
//            Iterator<String> itr = fieldNames.iterator();
//            while (itr.hasNext()) {
//                String fieldName = itr.next();
//                String fieldValue = vnp_Params.get(fieldName);
//                if ((fieldValue != null) && (fieldValue.length() > 0)) {
//                    hashData.append(fieldName);
//                    hashData.append('=');
//                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
//                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
//                    query.append('=');
//                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
//                    if (itr.hasNext()) {
//                        query.append('&');
//                        hashData.append('&');
//                    }
//                }
//            }
//            String queryUrl = query.toString();
//            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
//            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
//            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
//
//            response.sendRedirect(paymentUrl);
//
//        } else {
//            doGet(request, response);
//        }
//    }
//}