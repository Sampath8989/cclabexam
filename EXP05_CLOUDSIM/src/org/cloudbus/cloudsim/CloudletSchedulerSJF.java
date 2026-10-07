package org.cloudbus.cloudsim;

import java.util.Collections;
import java.util.Comparator;
import org.cloudbus.cloudsim.ResCloudlet;

/**
 * CloudletSchedulerSJF implements Shortest Job First (SJF) scheduling policy
 * that is NOT natively present in default CloudSim 3.x.
 * Cloudlets with the shortest total length (instructions) are scheduled first.
 */
public class CloudletSchedulerSJF extends CloudletSchedulerSpaceShared {

    public CloudletSchedulerSJF() {
        super();
    }

    @Override
    public double cloudletSubmit(Cloudlet gl, double fileTransferTime) {
        double result = super.cloudletSubmit(gl, fileTransferTime);
        sortWaitingListBySJF();
        return result;
    }

    @Override
    public double cloudletSubmit(Cloudlet gl) {
        double result = super.cloudletSubmit(gl);
        sortWaitingListBySJF();
        return result;
    }

    /**
     * Sorts the waiting queue so that cloudlets with smaller instruction length run first.
     */
    protected void sortWaitingListBySJF() {
        if (getCloudletWaitingList().size() > 1) {
            Collections.sort(getCloudletWaitingList(), new Comparator<ResCloudlet>() {
                @Override
                public int compare(ResCloudlet r1, ResCloudlet r2) {
                    return Long.compare(r1.getCloudletLength(), r2.getCloudletLength());
                }
            });
        }
    }
}
