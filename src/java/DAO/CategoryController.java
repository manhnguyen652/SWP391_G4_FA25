package DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Category;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author duong
 */
@WebServlet("/category")
public class CategoryController extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("category", dao.getCategoryById(id));
                req.getRequestDispatcher("category-detail.jsp").forward(req, resp);
                break;
            case "new":
                req.getRequestDispatcher("category-detail.jsp").forward(req, resp);
                break;
            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                dao.deleteCategory(deleteId);
                resp.sendRedirect("category");
                break;
            default:
                req.setAttribute("list", dao.getAllCategories());
                req.getRequestDispatcher("category-list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        int id = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);
        String name = req.getParameter("cate_name");

        Category c = new Category(id, name);
        if (id == 0)
            dao.insertCategory(c);
        else
            dao.updateCategory(c);

        resp.sendRedirect("category");
    }
}
