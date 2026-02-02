<?php
  include 'connection.php';
  $sql = "SELECT *
          FROM uas_contacts
          WHERE approve = 'APPROVED' OR approve = 'WAIT' 
          AND (
            (contact_request = ? AND contact_to = ?)
          OR 
            (contact_request = ? AND contact_to = ?)
          )
          LIMIT 1";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssss", $contact_request, $contact_to, $contact_to, $contact_request);
  $stmt->execute();
  $result = $stmt->get_result();
  if ($result -> num_rows > 0) {
    $arr = [
      "result" => "error",
      "message" => "Sudah terdaftar sebagai teman",
    ];
  } else {
    $sql = "INSERT INTO uas_contacts (contact_request, contact_to) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $contact_request, $contact_to);
    if ($stmt->execute()) {
      $arr = [
        "result" => "success",
        "message" => "Permintaan koneksi berhasil, di mohon menunggu !!",
      ];
    } else {
      $arr = [
        "result" => "error", 
        "message" => "Permintaan koneksi gagal",
      ];
    }     
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
