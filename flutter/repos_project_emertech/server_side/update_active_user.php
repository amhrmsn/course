<?php
  include 'connection.php';
  $sql = "UPDATE uas_profile SET fullname = ?, program = ?, biografi = ? WHERE email = ?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssss", $fullname, $program, $biografi, $email);
  if ($stmt->execute()) {
    $arr = [
      "result" => "success", 
      "message" => "Edit sukses",
    ];
  } else {
    $arr = [
      "result" => "error", 
      "message" => "Edit gagal",
    ];
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
