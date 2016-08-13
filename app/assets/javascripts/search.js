$(function() {
  $("#posts_search input").keyup(function() {
    $.get($("#posts_search").attr("action"), $("#posts_search").serialize(), null, "script");
    return false;
  });
});