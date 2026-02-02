<?php
  include 'connection.php';
  $sql = "SELECT 
            c.id,
            u.fullname,
            u.photo,
            u.nrp,
            u.program
          FROM uas_contacts AS c
          JOIN uas_profile AS u 
          ON u.email = c.contact_request
          WHERE c.contact_to = ? AND c.approve = 'WAIT'";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();
  $data = [];
  if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = array(
        "id"       => $row['id'],
        "fullname" => $row["fullname"],
        "photo"    => "images/" . htmlspecialchars($row["photo"]),
        "nrp"      => $row["nrp"],
        "program"  => $row["program"],
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