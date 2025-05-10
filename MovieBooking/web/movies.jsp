<%@ page import="java.util.*, com.movie.dao.MovieDAO, com.movie.model.Movie, com.movie.model.Theater, com.movie.model.ShowTime" %>

<%
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> movies = movieDAO.getMoviesWithTheatersAndShowTimes();
%>

<table border="1">
    <tr>
        <th>Movie Title</th>
        <th>Theater</th>
        <th>Location</th>
        <th>Show Times</th>
    </tr>
    <% for (Movie m : movies) { %>
        <% for (Theater t : m.getTheaters()) { %>
        <tr>
            <td><%= m.getTitle() %></td>
            <td><%= t.getName() %></td>
            <td><%= t.getLocation() %></td>
            <td>
                <% for (ShowTime s : t.getShowTimes()) { %>
                    <%= s.getTime() %> |
                <% } %>
            </td>
        </tr>
        <% } %>
    <% } %>
</table>
