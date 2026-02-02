<?php
  include 'connection.php';
  $sql = "UPDATE uas_contacts SET approve = 'REJECTED' WHERE id = ?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("i", $id);
  if ($stmt->execute()) {
    $arr = [
      "result" => "success", 
      "message" => "Aku gak mau temenan sama kamu",
    ];
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
