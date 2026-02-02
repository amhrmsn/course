<?php
  include 'connection.php';
  $sql = "SELECT fullname, photo, program, biografi FROM uas_profile WHERE email=? AND password=?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ss", $email, $password);
  $stmt->execute();
  $result = $stmt->get_result();
  if ($result->num_rows > 0) {
    $arr = [
      "result" => "success", 
      "message" => "Login sukses",
    ];
  } else {
    $arr = [
      "result" => "error", 
      "message" => "Login gagal",
    ];
  } 
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
