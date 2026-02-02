<?php
  include 'connection.php';
  $sql = "SELECT email, fullname, photo, nrp, program, biografi FROM uas_profile";
  $stmt = $conn->prepare($sql);
  $stmt->execute();
  $result = $stmt->get_result();
  $data = [];
  if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = array(
        "email"    => $row['email'],
        "fullname" => $row["fullname"],
        "photo"    => "images/" . htmlspecialchars($row["photo"]),
        "nrp"      => $row["nrp"],
        "program"  => $row["program"],
        "biografi" => $row["biografi"],
      );
    }
    $arr = [
      "result" => "success", 
      "data" => $data,
    ];
  } else {
	  $arr = [
      "result" => "error", 
      "message" => "sql error: $sql",
    ];
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>