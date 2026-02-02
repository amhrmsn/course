<?php
  include 'connection.php';
  $sql = "SELECT fullname, photo, program, biografi FROM uas_profile WHERE email = ?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();
  $data = [];
  if ($result -> num_rows > 0) {
    $row = $result->fetch_assoc();
    $arr = [
      "result" => "success", 
      "fullname" => $row["fullname"],
      "photo"    => "images/" . htmlspecialchars($row["photo"]),
      "nrp"      => $row["nrp"],
      "program"  => $row["program"],
      "biografi" => $row["biografi"]
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