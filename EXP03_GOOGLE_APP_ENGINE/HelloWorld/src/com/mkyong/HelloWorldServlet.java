package com.mkyong;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Experiment 03: Google App Engine Java Hello World Servlet
 * Source matches the legacy Google Plugin for Eclipse (GPE) project template.
 */
public class HelloWorldServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();
        out.println("Hello, World!");
        out.println("Cloud Computing Laboratory - Experiment 03: Google App Engine Java Application");
        out.println("Server running on local development port: 8888");
    }
}
