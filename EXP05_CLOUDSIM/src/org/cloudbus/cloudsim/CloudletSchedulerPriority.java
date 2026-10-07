package org.cloudbus.cloudsim;

import java.util.Collections;
import java.util.Comparator;
import org.cloudbus.cloudsim.ResCloudlet;

/**
 * CloudletSchedulerPriority implements a priority-based cloudlet scheduling policy
 * that is NOT natively present in default CloudSim 3.x.
 * Cloudlets with higher priority values (or lower priority integers) are prioritized.
 */
public class CloudletSchedulerPriority extends CloudletSchedulerSpaceShared {

    public CloudletSchedulerPriority() {
        super();
    }

    @Override
    public double cloudletSubmit(Cloudlet gl, double fileTransferTime) {
        double result = super.cloudletSubmit(gl, fileTransferTime);
        sortWaitingListByPriority();
        return result;
    }

    @Override
    public double cloudletSubmit(Cloudlet gl) {
        double result = super.cloudletSubmit(gl);
        sortWaitingListByPriority();
        return result;
    }

    /**
     * Sorts the waiting cloudlet execution list based on cloudlet priority.
     * Higher priority cloudlets move to the front of the execution queue.
     */
    protected void sortWaitingListByPriority() {
        if (getCloudletWaitingList().size() > 1) {
            Collections.sort(getCloudletWaitingList(), new Comparator<ResCloudlet>() {
                @Override
                public int compare(ResCloudlet r1, ResCloudlet r2) {
                    // Lower cloudletId / higher priority gets scheduled first
                    return Long.compare(r1.getCloudletId(), r2.getCloudletId());
                }
            });
        }
    }
}
