<?php

$data = array(
	array('R1', 'R2', 'R3', 'R4', 'R5'),
	array(
		array(
			'sourceID' => 'R1',
			'destID' => 'R2',
			'bandWidth' => 2,
			'path' => array('R1', 'R2'),
			'timeDelay' => 10,
			'tenant' => 'A',
		),
		array(
			'sourceID' => 'R2',
			'destID' => 'R3',
			'bandWidth' => 2,
			'path' => array('R2', 'R3'),
			'timeDelay' => 10,
			'tenant' => 'A',
		),
		array(
			'sourceID' => 'R3',
			'destID' => 'R4',
			'bandWidth' => 2,
			'path' => array('R3', 'R4'),
			'timeDelay' => 20,
			'tenant' => 'B',
		),
		array(
			'sourceID' => 'R1',
			'destID' => 'R5',
			'bandWidth' => 2,
			'path' => array('R1', 'R5'),
			'timeDelay' => 15,
			'tenant' => 'C',
		),
	),
);

print json_encode($data)

?>