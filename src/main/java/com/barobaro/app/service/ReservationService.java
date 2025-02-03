package com.barobaro.app.service;

public interface ReservationService {
	public int processReservation(long timeSlotSeq);
	public int acceptReservation(long reservationSeq);
	public int processRefuseReservation(long reservationSeq);
	public int cancleRequest(long reservationSeq);
	public int processCancleAccept(long reservationSeq);
	public int done(long reservationSeq);
}
