<?php
  include 'connection.php';
  $sql = "SELECT * FROM uas_profile WHERE email = ?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();
  if ($result->num_rows > 0) {
    $arr = [
        "result" => "error", 
        "message" => "Email sudah terdaftar",
    ];
  } else {
    $sql = "INSERT INTO uas_profile (email, password, fullname, photo, nrp) VALUES (?, ?, ?, ?, ?)";
    $url_default = "avatar.png";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssi", $email, $password, $fullname, $url_default, $nrp);
    if ($stmt->execute()) {
      $arr = [
        "result" => "success",
        "message" => "Registrasi berhasil",
    ];
    } else {
      $arr = [
        "result" => "error", 
        "message" => "Registrasi gagal",
      ];
    }
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
