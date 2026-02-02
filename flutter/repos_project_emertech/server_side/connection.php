<?php
  header("Access-Control-Allow-Origin: *");
  header("Content-Type: application/json; charset=UTF-8");
  $arr = null;
  $conn = new mysqli("localhost", "flutter_160421077", "ubaya", "flutter_160421077");
  if ($conn->connect_error) {
      $arr = [
        "result" => "error", 
        "message" => "unable to connect",
      ];
  }
  extract($_POST);
?>
